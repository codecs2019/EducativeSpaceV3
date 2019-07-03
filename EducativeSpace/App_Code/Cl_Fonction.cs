﻿using System;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using DevExpress.Web;
using System.Runtime.CompilerServices;
using System.Reflection;
using System.IO;
using System.Net;
using OfficeOpenXml;
using System.Collections.Generic;
using Microsoft.AspNet.SignalR;

namespace ErpMasterSuite.Models
{
    public class Cl_Fonction
    {

        public static string prefixe_url = System.Configuration.ConfigurationManager.AppSettings["AppId"];

        protected static string AuthAPI()
        {
            string crypt = "Basic " + Convert.ToBase64String(System.Text.Encoding.ASCII.GetBytes(string.Format("{0}:{1}", "SoroZieEmaster", "ced799b3ef25cf93e815d9dd2c479fad")));
            return crypt;
        }

        public static string Appel_synchronePOST(string url, string json)
        {
            string result = string.Empty;
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(url);
            httpWebRequest.ContentType = "application/json; charset=UTF-8";
            httpWebRequest.Method = "POST";
            httpWebRequest.Headers.Add("Authorization", AuthAPI());
            using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
            {
                //param_transfer.Termination = param_termin;
                //string json = new JavaScriptSerializer().Serialize(param_transfer);

                streamWriter.Write(json);
                streamWriter.Flush();
                streamWriter.Close();
            }

            HttpWebResponse httpResponse;

            try
            {
                httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            }
            catch (WebException ex)
            {
                httpResponse = ex.Response as HttpWebResponse;
                result = "error";
            }

            using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
            {
                result = streamReader.ReadToEnd();
            }

            return result;
        }




        public static string Appel_synchroneGet(string url)
        {
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(url);

            HttpWebResponse httpResponse;
            httpWebRequest.Headers.Add("Authorization", AuthAPI());

            try
            {
                httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            }
            catch (WebException ex)
            {
                httpResponse = ex.Response as HttpWebResponse;
                return "error";
            }

            using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
            {
                return streamReader.ReadToEnd();
            }

            return "vide";
        }


        //public async Task<RootObjectPack> Appel_asynchrone()
        //{
        //    using (var client = new HttpClient())
        //    {
        //        var response = new RootObjectPack();
        //        client.BaseAddress = new Uri("http://localhost/elicenceAPI/api/Licence/GetPack");
        //        client.DefaultRequestHeaders.Add("ContentType", "application/json; charset=UTF-8");

        //        var responseMessage = new HttpResponseMessage();
        //        responseMessage.Headers.Add("ContentType", "application/json; charset=UTF-8");
        //        responseMessage = await client.GetAsync(client.BaseAddress);

        //        var result = await responseMessage.Content.ReadAsStringAsync();
        //        if (responseMessage.IsSuccessStatusCode)
        //        {
        //            response = JsonConvert.DeserializeObject<RootObjectPack>(result);
        //        }

        //        return response;
        //    }
        //}



        public static String StrLicence()
        {
            String Str = "Data Source=.;Initial Catalog=Elicence;Integrated Security=True";
            return Str;
        }


        public static DataSet Extraction_dsLicence(string SP, ArrayList Cles, ArrayList Valeurs)
        {
            using (SqlConnection cnx = new SqlConnection(StrLicence()))
            {

                using (SqlCommand cmd = new SqlCommand { CommandText = SP, CommandType = CommandType.StoredProcedure, Connection = cnx })
                {
                    DataSet ds = new DataSet();

                    SqlDataAdapter da = new SqlDataAdapter();
                    //Execution en mode deconnecté
                    for (int i = 0; i <= Cles.Count - 1; i++)
                    {
                        cmd.Parameters.AddWithValue(Convert.ToString(Cles[i]), Valeurs[i]);
                    }

                    da.SelectCommand = cmd;
                    //Remplissage du dataset
                    da.Fill(ds);
                    return ds;

                }
            }
        }

        public static DataTable Extraction_dsLicence(string SP, ArrayList Cles, ArrayList Valeurs, ref DataTable DT)
        {
            using (SqlConnection cnx = new SqlConnection(StrLicence()))
            {
                using (SqlCommand cmd = new SqlCommand { CommandText = SP, CommandType = CommandType.StoredProcedure, Connection = cnx })
                {

                    // DataTable ds = new DataTable();
                    SqlDataAdapter da = new SqlDataAdapter();
                    //Execution en mode deconnecté
                    for (int i = 0; i <= Cles.Count - 1; i++)
                    {
                        cmd.Parameters.AddWithValue(Convert.ToString(Cles[i]), Valeurs[i]);
                    }

                    da.SelectCommand = cmd;
                    //Remplissage du dataset
                    da.Fill(DT);
                    return DT;
                }
            }
        }

        public static String Str()
        {
            try
            {
                string Chaine = Convert.ToString(System.Web.HttpContext.Current.Session["GlobalConnectionString"]);
                //Session["GlobalConnectionString"].ToString();
                String Str = System.Configuration.ConfigurationManager.ConnectionStrings[Chaine].ToString();
                return Str;
            }
            catch (Exception)
            {
                String Str = System.Configuration.ConfigurationManager.ConnectionStrings["MasterSuiteConnectionString"].ToString();
                return Str;
            }
            
        }

        //RECHERCHE D ELEMENT DANS UNE TABLE
        public static DataTable ReturnLine(String sColonneReturn, String sColonneSender, String sValeurcode, String sTable, ref DataTable dt)
        {

            using (SqlConnection cnx = new SqlConnection(Str()))
            {
                cnx.Open();
                String SQL_RQ = String.Format("SELECT {0} FROM {3} WHERE {1}='{2}' ", sColonneReturn, sColonneSender, sValeurcode, sTable);

                SqlCommand cmd = new SqlCommand();
                SqlDataAdapter Adapter = new SqlDataAdapter();

                cmd.Connection = cnx;
                cmd.CommandText = SQL_RQ;
                cmd.CommandType = CommandType.Text;

                Adapter.SelectCommand = cmd;
                try
                {
                    Adapter.Fill(dt);
                }
                catch (Exception ex)
                {
                    throw (ex);
                }
                return dt;

            }
        }

        //RECHERCHE D ELEMENT DANS UNE TABLE 
        public static DataTable ReturnLine(String sColonneReturn, String sColonneSender, int sValeurcode, String sTable, String sColonneSender2, int sValeurcode2, ref DataTable dt)
        {

            using (SqlConnection cnx = new SqlConnection(Str()))
            {
                cnx.Open();
                String SQL_RQ = String.Format("SELECT {0} FROM {3} WHERE {1}={2} AND {4}={5} ", sColonneReturn, sColonneSender, sValeurcode, sTable, sColonneSender2, sValeurcode2);

                SqlCommand cmd = new SqlCommand();
                SqlDataAdapter Adapter = new SqlDataAdapter();

                cmd.Connection = cnx;
                cmd.CommandText = SQL_RQ;
                cmd.CommandType = CommandType.Text;

                Adapter.SelectCommand = cmd;
                try
                {
                    Adapter.Fill(dt);
                }
                catch (Exception ex)
                {
                    throw (ex);
                }
                return dt;

            }
        }

        //RECHERCHE D ELEMENT DANS UNE TABLE 
        public static DataTable ReturnLine(String sColonneReturn, String sColonneSender, String sValeurcode, String sTable, String sColonneSender2, int sValeurcode2, ref DataTable dt)
        {

            using (SqlConnection cnx = new SqlConnection(Str()))
            {
                cnx.Open();
                String SQL_RQ = String.Format("SELECT {0} FROM {3} WHERE {1}='{2}' AND {4}={5} ", sColonneReturn, sColonneSender, sValeurcode, sTable, sColonneSender2, sValeurcode2);

                SqlCommand cmd = new SqlCommand();
                SqlDataAdapter Adapter = new SqlDataAdapter();

                cmd.Connection = cnx;
                cmd.CommandText = SQL_RQ;
                cmd.CommandType = CommandType.Text;

                Adapter.SelectCommand = cmd;
                try
                {
                    Adapter.Fill(dt);
                }
                catch (Exception ex)
                {
                    throw (ex);
                }
                return dt;

            }
        }


        //RECHERCHE D ELEMENT DANS UNE TABLE
        public static DataTable ReturnLine(String sColonneReturn, String sColonneSender, int sValeurcode, String sTable, ref DataTable dt)
        {

            using (SqlConnection cnx = new SqlConnection(Str()))
            {
                cnx.Open();
                String SQL_RQ = String.Format("SELECT {0} FROM {3} WHERE {1}='{2}' ", sColonneReturn, sColonneSender, sValeurcode, sTable);

                SqlCommand cmd = new SqlCommand();
                SqlDataAdapter Adapter = new SqlDataAdapter();

                cmd.Connection = cnx;
                cmd.CommandText = SQL_RQ;
                cmd.CommandType = CommandType.Text;

                Adapter.SelectCommand = cmd;
                try
                {
                    Adapter.Fill(dt);
                }
                catch (Exception ex)
                {
                    throw (ex);
                }
                return dt;

            }
        }

        //Surcharge
        public static DataTable ReturnLine(String sColonneReturn, String sColonneSender, String sValeurcode, String sTable, String sColonneSender2, int sValeurcode2, String sColonneSender3, int sValeurcode3, ref DataTable dt)
        {

            using (SqlConnection cnx = new SqlConnection(Str()))
            {
                cnx.Open();
                String SQL_RQ = String.Format("SELECT {0} FROM {3} WHERE {1}='{2}' AND {4}={5} AND {6}={7} ", sColonneReturn, sColonneSender, sValeurcode, sTable, sColonneSender2, sValeurcode2, sColonneSender3, sValeurcode3);

                SqlCommand cmd = new SqlCommand();
                SqlDataAdapter Adapter = new SqlDataAdapter();

                cmd.Connection = cnx;
                cmd.CommandText = SQL_RQ;
                cmd.CommandType = CommandType.Text;

                Adapter.SelectCommand = cmd;
                try
                {
                    Adapter.Fill(dt);
                }
                catch (Exception ex)
                {
                    throw (ex);
                }
                return dt;

            }
        }

        //Surcharge 10/08/2012
        public static DataTable ReturnLine(String sColonneReturn, String sColonneSender, String sValeurcode, String sTable, String sColonneSender2, int sValeurcode2, String sColonneSender3, int sValeurcode3, String sColonneSender4, int sValeurcode4, ref DataTable dt)
        {

            using (SqlConnection cnx = new SqlConnection(Str()))
            {
                cnx.Open();
                String SQL_RQ = String.Format("SELECT {0} FROM {3} WHERE {1}='{2}' AND {4}={5} AND {6}={7} AND {8}={9}", sColonneReturn, sColonneSender, sValeurcode, sTable, sColonneSender2, sValeurcode2, sColonneSender3, sValeurcode3, sColonneSender4, sValeurcode4);

                SqlCommand cmd = new SqlCommand();
                SqlDataAdapter Adapter = new SqlDataAdapter();

                cmd.Connection = cnx;
                cmd.CommandText = SQL_RQ;
                cmd.CommandType = CommandType.Text;

                Adapter.SelectCommand = cmd;
                try
                {
                    Adapter.Fill(dt);
                }
                catch (Exception ex)
                {
                    throw (ex);
                }
                return dt;

            }
        }

        //Surcharge 10/08/2012_2
        public static DataTable ReturnLine(String sColonneReturn, String sColonneSender, String sValeurcode, String sTable, String sColonneSender2, int sValeurcode2, String sColonneSender3, int sValeurcode3, String sColonneSender4, string sValeurcode4, ref DataTable dt)
        {

            using (SqlConnection cnx = new SqlConnection(Str()))
            {
                cnx.Open();
                String SQL_RQ = String.Format("SELECT {0} FROM {3} WHERE {1}='{2}' AND {4}={5} AND {6}={7} AND {8}='{9}'", sColonneReturn, sColonneSender, sValeurcode, sTable, sColonneSender2, sValeurcode2, sColonneSender3, sValeurcode3, sColonneSender4, sValeurcode4);

                SqlCommand cmd = new SqlCommand();
                SqlDataAdapter Adapter = new SqlDataAdapter();

                cmd.Connection = cnx;
                cmd.CommandText = SQL_RQ;
                cmd.CommandType = CommandType.Text;

                Adapter.SelectCommand = cmd;
                try
                {
                    Adapter.Fill(dt);
                }
                catch (Exception ex)
                {
                    throw (ex);
                }
                return dt;

            }
        }

        //Surcharge 11/03/2013_2
        public static DataTable ReturnLine(String sColonneReturn, String sColonneSender, String sValeurcode, String sTable, String sColonneSender2, int sValeurcode2, String sColonneSender3, int sValeurcode3, String sColonneSender4, string sValeurcode4, String sColonneSender5, string sValeurcode5, ref DataTable dt)
        {

            using (SqlConnection cnx = new SqlConnection(Str()))
            {
                cnx.Open();
                String SQL_RQ = String.Format("SELECT {0} FROM {3} WHERE {1}='{2}' AND {4}={5} AND {6}={7} AND {8}='{9}' AND {10}='{11}'", sColonneReturn, sColonneSender, sValeurcode, sTable, sColonneSender2, sValeurcode2, sColonneSender3, sValeurcode3, sColonneSender4, sValeurcode4, sColonneSender5, sValeurcode5);

                SqlCommand cmd = new SqlCommand();
                SqlDataAdapter Adapter = new SqlDataAdapter();

                cmd.Connection = cnx;
                cmd.CommandText = SQL_RQ;
                cmd.CommandType = CommandType.Text;

                Adapter.SelectCommand = cmd;
                try
                {
                    Adapter.Fill(dt);
                }
                catch (Exception ex)
                {
                    throw (ex);
                }
                return dt;

            }
        }

        //Surcharge 11/03/2013_2
        public static DataTable ReturnLine(String sColonneReturn, String sColonneSender, String sValeurcode, String sTable, String sColonneSender2, int sValeurcode2, String sColonneSender3, int sValeurcode3, String sColonneSender4, string sValeurcode4, String sColonneSender5, int sValeurcode5, ref DataTable dt)
        {

            using (SqlConnection cnx = new SqlConnection(Str()))
            {
                cnx.Open();
                String SQL_RQ = String.Format("SELECT {0} FROM {3} WHERE {1}='{2}' AND {4}={5} AND {6}={7} AND {8}='{9}' AND {10}={11}", sColonneReturn, sColonneSender, sValeurcode, sTable, sColonneSender2, sValeurcode2, sColonneSender3, sValeurcode3, sColonneSender4, sValeurcode4, sColonneSender5, sValeurcode5);

                SqlCommand cmd = new SqlCommand();
                SqlDataAdapter Adapter = new SqlDataAdapter();

                cmd.Connection = cnx;
                cmd.CommandText = SQL_RQ;
                cmd.CommandType = CommandType.Text;

                Adapter.SelectCommand = cmd;
                try
                {
                    Adapter.Fill(dt);
                }
                catch (Exception ex)
                {
                    throw (ex);
                }
                return dt;

            }
        }

        //----------------------------------- vérification de code unique avant insertion
        public static Boolean Verification_Code(String sTable, String sColonne, int sValeur)
        {
            Boolean sResultat = false;
            using (SqlConnection cnx = new SqlConnection(Str()))
            {
                cnx.Open();
                String sCmd = String.Format("SELECT {0} FROM {1} WHERE {0}= {2} ", sColonne, sTable, sValeur);
                DataTable Dt = new DataTable();

                SqlCommand cmd = new SqlCommand(sCmd, cnx) { CommandType = CommandType.Text };
                SqlDataAdapter Da = new SqlDataAdapter(cmd);

                Da.Fill(Dt);
                if (Dt.Rows.Count > 0)
                {
                    sResultat = true;
                }
                else
                {
                    sResultat = false;
                }

            }
            return sResultat;


        }

        public static Boolean Verification_Code(String sTable, String sColonne, String sValeur)
        {
            Boolean sResultat = false;
            using (SqlConnection cnx = new SqlConnection(Str()))
            {
                cnx.Open();
                String sCmd = String.Format("SELECT {0} FROM {1} WHERE {0}='{2}'", sColonne, sTable, sValeur);
                DataTable Dt = new DataTable();

                SqlCommand cmd = new SqlCommand(sCmd, cnx) { CommandType = CommandType.Text };
                SqlDataAdapter Da = new SqlDataAdapter(cmd);
                try
                {
                    Da.Fill(Dt);
                    if (Dt.Rows.Count > 0)
                    {
                        sResultat = true;
                    }
                    else
                    {
                        sResultat = false;
                    }
                }
                catch (Exception ex)
                {
                    throw (ex);
                }
                finally
                {
                    cnx.Close();
                }

            }
            return sResultat;


        }

        public static Boolean Verification_Code(String sTable, String sColonne, String sValeur, String sColonne1, int sValeur1)
        {
            Boolean sResultat = false;
            using (SqlConnection cnx = new SqlConnection(Str()))
            {
                cnx.Open();
                String sCmd = String.Format("SELECT {0} FROM {1} WHERE {0}='{2}'  AND {3}='{4}' ", sColonne, sTable, sValeur, sColonne1, sValeur1);
                DataTable Dt = new DataTable();

                SqlCommand cmd = new SqlCommand(sCmd, cnx) { CommandType = CommandType.Text };
                SqlDataAdapter Da = new SqlDataAdapter(cmd);
                try
                {
                    Da.Fill(Dt);
                    if (Dt.Rows.Count > 0)
                    {
                        sResultat = true;
                    }
                    else
                    {
                        sResultat = false;
                    }
                }
                catch (Exception ex)
                {
                    throw (ex);
                }
                finally
                {
                    cnx.Close();
                }

            }
            return sResultat;


        }

        public static Boolean Verification_Code(String sTable, String sColonne, int sValeur, String sColonne1, int sValeur1)
        {
            Boolean sResultat = false;
            using (SqlConnection cnx = new SqlConnection(Str()))
            {
                cnx.Open();
                String sCmd = String.Format("SELECT {0} FROM {1} WHERE {0}={2}  AND {3}='{4}' ", sColonne, sTable, sValeur, sColonne1, sValeur1);
                DataTable Dt = new DataTable();

                SqlCommand cmd = new SqlCommand(sCmd, cnx) { CommandType = CommandType.Text };
                SqlDataAdapter Da = new SqlDataAdapter(cmd);
                try
                {
                    Da.Fill(Dt);
                    if (Dt.Rows.Count > 0)
                    {
                        sResultat = true;
                    }
                    else
                    {
                        sResultat = false;
                    }
                }
                catch (Exception ex)
                {
                    throw (ex);
                }
                finally
                {
                    cnx.Close();
                }

            }
            return sResultat;


        }

        public static Int32 Numero_Auto(Int32 i, String sTable, String sColonne, int sSite)
        {



            using (SqlConnection cnx = new SqlConnection(Str()))
            {
                Int32 sCode = 0;
                cnx.Open();
                String sCmd = String.Format("SELECT {0} FROM {1} WHERE SITE_ID='{2}'", sColonne, sTable, sSite);
                DataTable Dt = new DataTable();
                SqlCommand cmd = new SqlCommand(sCmd, cnx) { CommandType = CommandType.Text };
                SqlDataAdapter Da = new SqlDataAdapter(cmd);
                try
                {
                    Da.Fill(Dt);
                    sCode = Int32.Parse((Dt.Rows[0][0]).ToString());
                    sCode = sCode + i;

                    String sCmd2 = String.Format("UPDATE  {1} SET {0}='{2}' WHERE SITE_ID='{3}'", sColonne, sTable, sCode, sSite);
                    SqlCommand cmd2 = new SqlCommand(sCmd2, cnx);
                    cmd2.CommandType = CommandType.Text;
                    cmd2.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    throw (ex);
                }
                finally
                {
                    cnx.Close();
                }
                return sCode;
            }




        }
        public static Int32 Numero_Auto(Int32 i, String sTable, String sColonne)
        {



            using (SqlConnection cnx = new SqlConnection(Str()))
            {
                Int32 sCode = 0;
                cnx.Open();
                String sCmd = String.Format("SELECT {0} FROM {1} ", sColonne, sTable);
                DataTable Dt = new DataTable();
                SqlCommand cmd = new SqlCommand(sCmd, cnx) { CommandType = CommandType.Text };
                SqlDataAdapter Da = new SqlDataAdapter(cmd);
                try
                {
                    Da.Fill(Dt);
                    sCode = Int32.Parse((Dt.Rows[0][0]).ToString());
                    sCode = sCode + i;

                    String sCmd2 = String.Format("UPDATE  {1} SET {0}='{2}' ", sColonne, sTable, sCode);
                    SqlCommand cmd2 = new SqlCommand(sCmd2, cnx);
                    cmd2.CommandType = CommandType.Text;
                    cmd2.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    throw (ex);
                }
                finally
                {
                    cnx.Close();
                }
                return sCode;
            }




        }

        public static int GetIntTxt(string txt, ASPxGridView Grid)
        {

            try
            {
                ASPxTextBox Element = Grid.FindEditFormTemplateControl(txt) as ASPxTextBox;
                return Convert.ToInt32(Element.Text);
            }
            catch (Exception)
            {
                return 0;
            }
        }

        public static float GetFloatTxt(string txt, ASPxGridView Grid)
        {

            ASPxTextBox Element = Grid.FindEditFormTemplateControl(txt) as ASPxTextBox;
            return float.Parse(Element.Text);
        }

        public static string GetStringTxt(string txt, ASPxGridView Grid)
        {

            ASPxTextBox Element = Grid.FindEditFormTemplateControl(txt) as ASPxTextBox;
            return Element.Text;
        }

        //COMBOBOX
        public static string GetStringCmb(string Cmb, ASPxGridView Grid)
        {

            ASPxComboBox Element = Grid.FindEditFormTemplateControl(Cmb) as ASPxComboBox;
            return Convert.ToString(Element.Value);
        }

        public static Boolean GetCheckCmb(string Cmb, ASPxGridView Grid)
        {

            ASPxCheckBox Element = Grid.FindEditFormTemplateControl(Cmb) as ASPxCheckBox;
            return Convert.ToBoolean(Element.Checked);
        }

        public static string GetStringCmbReturnText(string Cmb, ASPxGridView Grid)
        {

            ASPxComboBox Element = Grid.FindEditFormTemplateControl(Cmb) as ASPxComboBox;
            return Convert.ToString(Element.Text);
        }
        public static int GetIntChk(string Chk, ASPxGridView Grid)
        {

            ASPxCheckBox Element = Grid.FindEditFormTemplateControl(Chk) as ASPxCheckBox;
            return Convert.ToInt32(Element.Value);
        }

        public static int GetIntCmb(string Cmb, ASPxGridView Grid)
        {

            ASPxComboBox Element = Grid.FindEditFormTemplateControl(Cmb) as ASPxComboBox;
            return Convert.ToInt32(Element.Value);
        }

        public static string GetstringCmb(string Cmb, ASPxGridView Grid)
        {

            ASPxComboBox Element = Grid.FindEditFormTemplateControl(Cmb) as ASPxComboBox;
            return Element.Value.ToString();
        }

        //DATE
        public static DateTime GetDate(string SelectDate, ASPxGridView Grid)
        {

            ASPxDateEdit Element = Grid.FindEditFormTemplateControl(SelectDate) as ASPxDateEdit;
            return Convert.ToDateTime(Element.Date);
        }

        //MEMO
        public static string GetStringMemo(string memo, ASPxGridView Grid)
        {

            ASPxMemo Element = Grid.FindEditFormTemplateControl(memo) as ASPxMemo;
            return Element.Text;
        }


        //GET VALUE ON PAGE CONTROL
        //TEXTBOX
        public static string GetMemo(string txt, ASPxGridView Grid, string PageControl)
        {
            ASPxPageControl pgCntrol = Grid.FindEditFormTemplateControl(PageControl) as ASPxPageControl;
            ASPxMemo Element = pgCntrol.FindControl(txt) as ASPxMemo;
            return Element.Text;
        }

        public static int GetIntTxt(string txt, ASPxGridView Grid, string PageControl)
        {
            ASPxPageControl pgCntrol = Grid.FindEditFormTemplateControl(PageControl) as ASPxPageControl;
            ASPxTextBox Element = pgCntrol.FindControl(txt) as ASPxTextBox;
            return Convert.ToInt32(Element.Text);
        }

        public static float GetFloatTxt(string txt, ASPxGridView Grid, string PageControl)
        {
            float r = float.Parse("0,00");
            ASPxPageControl pgCntrol = Grid.FindEditFormTemplateControl(PageControl) as ASPxPageControl;
            ASPxTextBox Element = pgCntrol.FindControl(txt) as ASPxTextBox;
            if (Element.Text == "")
                r = float.Parse("0,00");
            else
                r = float.Parse(Element.Text);
            return r;
        }

        public static string GetStringTxt(string txt, ASPxGridView Grid, string PageControl)
        {
            ASPxPageControl pgCntrol = Grid.FindEditFormTemplateControl(PageControl) as ASPxPageControl;
            ASPxTextBox Element = pgCntrol.FindControl(txt) as ASPxTextBox;
            return Element.Text;
        }

        //COMBOBOX
        public static string GetStringCmb(string Cmb, ASPxGridView Grid, string PageControl)
        {
            ASPxPageControl pgCntrol = Grid.FindEditFormTemplateControl(PageControl) as ASPxPageControl;
            ASPxComboBox Element = pgCntrol.FindControl(Cmb) as ASPxComboBox;
            return Convert.ToString(Element.Value);
        }

        public static string GetTextCmb(string Cmb, ASPxGridView Grid, string PageControl)
        {
            ASPxPageControl pgCntrol = Grid.FindEditFormTemplateControl(PageControl) as ASPxPageControl;
            ASPxComboBox Element = pgCntrol.FindControl(Cmb) as ASPxComboBox;
            return Convert.ToString(Element.Text);
        }


        public static int GetIntCmb(string Cmb, ASPxGridView Grid, string PageControl)
        {
            int r = 0;
            ASPxPageControl pgCntrol = Grid.FindEditFormTemplateControl(PageControl) as ASPxPageControl;
            ASPxComboBox Element = pgCntrol.FindControl(Cmb) as ASPxComboBox;
            if (Element.Text == "")
                r = 0;
            else
                r = Convert.ToInt32(Element.Value);
            return r;
        }


        //DATE
        public static DateTime GetDate(string SelectDate, ASPxGridView Grid, string PageControl)
        {
            ASPxPageControl pgCntrol = Grid.FindEditFormTemplateControl(PageControl) as ASPxPageControl;
            ASPxDateEdit Element = pgCntrol.FindControl(SelectDate) as ASPxDateEdit;
            return Convert.ToDateTime(Element.Date);
        }

        //MEMO
        public static string GetStringMemo(string memo, ASPxGridView Grid, string PageControl)
        {
            ASPxPageControl pgCntrol = Grid.FindEditFormTemplateControl(PageControl) as ASPxPageControl;
            ASPxMemo Element = pgCntrol.FindControl(memo) as ASPxMemo;
            return Element.Text;
        }

        //GRIDVIEW
        public static ASPxGridView GetGridView(string grid, ASPxGridView Grid)
        {
            ASPxGridView Element = Grid.FindControl(grid) as ASPxGridView;
            return Element;
        }

        //GRIDVIEW
        public static ASPxGridView GetGridView(string grid, ASPxGridView Grid, string PageControl)
        {
            ASPxPageControl pgCntrol = Grid.FindEditFormTemplateControl(PageControl) as ASPxPageControl;
            ASPxGridView Element = pgCntrol.FindControl(grid) as ASPxGridView;
            return Element;
        }


        public static int GetIntLookup(string Cmb, ASPxGridView Grid)
        {
            ASPxGridLookup Element = Grid.FindEditFormTemplateControl(Cmb) as ASPxGridLookup;
            return Convert.ToInt32(Element.Value);
        }

        //UploadControl
        public static ASPxUploadControl GetUploadControl(string upload, ASPxGridView Grid)
        {
            ASPxUploadControl Element = Grid.FindControl(upload) as ASPxUploadControl;
            return Element;
        }


        /////////---------------------------------------------------------------------------------------------////

        //MESSAGE BOX

        public static void MessageBox(string LabelName, string message, ASPxGridView Grid, string PageControl)
        {
            ASPxPageControl pgCntrol = Grid.FindEditFormTemplateControl(PageControl) as ASPxPageControl;
            ASPxLabel Element = pgCntrol.FindControl(LabelName) as ASPxLabel;
            Element.Text = message;
        }

        //***********************************************************************************//
        //------------------------------------Procedure de mise a jour sur 2 tables
        public static void Execute_Commande_StoreProc(string SP, ArrayList Cles, ArrayList Valeurs)
        {
            using (SqlConnection cnx = new SqlConnection(Str()))
            {

                using (SqlCommand cmd = new SqlCommand { CommandText = SP, CommandType = CommandType.StoredProcedure, Connection = cnx })
                {
                    cmd.CommandTimeout = 5000;

                    for (int i = 0; i <= Cles.Count - 1; i++)
                    {
                        cmd.Parameters.AddWithValue(Convert.ToString(Cles[i]), Valeurs[i]);
                    }

                    cnx.Open();
                    cmd.ExecuteReader();
                    cnx.Close();

                }

            }


        }



        public static void Execute_Commande_StoreProc(string SP, string SP2, ArrayList Cles, ArrayList Valeurs, ArrayList Cles2, ArrayList Valeurs2)
        {


            using (SqlConnection cnx = new SqlConnection(Str()))
            {
                cnx.Open();
                SqlCommand cmd = new SqlCommand();
                SqlTransaction trans = null;
                trans = cnx.BeginTransaction();
                cmd.Connection = cnx;
                cmd.Transaction = trans;
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    cmd.CommandText = SP;

                    for (int i = 0; i <= Cles.Count - 1; i++)
                    {
                        cmd.Parameters.AddWithValue(Convert.ToString(Cles[i]), Valeurs[i]);
                    }
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = SP2;
                    cmd.Parameters.Clear();
                    for (int i = 0; i <= Cles2.Count - 1; i++)
                    {
                        cmd.Parameters.AddWithValue(Convert.ToString(Cles2[i]), Valeurs2[i]);
                    }

                    cmd.ExecuteNonQuery();
                    trans.Commit();

                }

                catch (Exception ex)
                {
                    trans.Rollback();
                    throw (ex);
                }
                finally
                {
                    cnx.Close();
                }

            }



        }



        // procedure de transaction de mise à jour sur 3 table
        public static void Execute_Commande_StoreProc(string SP, string SP2, string SP3, ArrayList Cles, ArrayList Valeurs, ArrayList Cles2, ArrayList Valeurs2, ArrayList Cles3, ArrayList Valeurs3)
        {


            using (SqlConnection cnx = new SqlConnection(Str()))
            {
                cnx.Open();
                SqlCommand cmd = new SqlCommand();
                SqlTransaction trans = null;
                trans = cnx.BeginTransaction();
                cmd.Connection = cnx;
                cmd.Transaction = trans;
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    cmd.CommandText = SP;

                    for (int i = 0; i <= Cles.Count - 1; i++)
                    {
                        cmd.Parameters.AddWithValue(Convert.ToString(Cles[i]), Valeurs[i]);
                    }
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = SP2;
                    cmd.Parameters.Clear();

                    for (int i = 0; i <= Cles2.Count - 1; i++)
                    {
                        cmd.Parameters.AddWithValue(Convert.ToString(Cles2[i]), Valeurs2[i]);
                    }

                    cmd.ExecuteNonQuery();


                    cmd.ExecuteNonQuery();
                    cmd.CommandText = SP3;
                    cmd.Parameters.Clear();
                    for (int i = 0; i <= Cles2.Count - 1; i++)
                    {
                        cmd.Parameters.AddWithValue(Convert.ToString(Cles2[i]), Valeurs2[i]);
                    }

                    cmd.ExecuteNonQuery();
                    trans.Commit();

                }

                catch (Exception ex)
                {
                    trans.Rollback();
                    throw (ex);
                }
                finally
                {
                    cnx.Close();
                }

            }



        }

        //-------------------------------------procedure  de recherche retournant un dataset /remplissage de combobox , datgrid

        public static DataSet Extraction_ds(string SP)
        {


            using (SqlConnection cnx = new SqlConnection(Str()))
            {

                using (SqlCommand cmd = new SqlCommand { CommandText = SP, CommandType = CommandType.StoredProcedure, Connection = cnx })
                {

                    DataSet ds = new DataSet();
                    SqlDataAdapter da = new SqlDataAdapter();
                    //Execution en mode deconnecté
                    da.SelectCommand = cmd;
                    //Remplissage du dataset
                    da.Fill(ds);
                    return ds;


                }

            }

        }


        //Mise a jour William 13072015

        public static DataTable Extraction_ds(string SP, ref DataTable DT)
        {


            using (SqlConnection cnx = new SqlConnection(Str()))
            {

                using (SqlCommand cmd = new SqlCommand { CommandText = SP, CommandType = CommandType.StoredProcedure, Connection = cnx })
                {

                    // DataTable ds = new DataTable();
                    SqlDataAdapter da = new SqlDataAdapter();

                    da.SelectCommand = cmd;
                    //Remplissage du dataset
                    da.Fill(DT);
                    return DT;


                }

            }

        }

        public static DataSet Extraction_ds(string SP, ArrayList Cles, ArrayList Valeurs)
        {


            using (SqlConnection cnx = new SqlConnection(Str()))
            {

                using (SqlCommand cmd = new SqlCommand { CommandText = SP, CommandType = CommandType.StoredProcedure, Connection = cnx })
                {
                    DataSet ds = new DataSet();

                    SqlDataAdapter da = new SqlDataAdapter();
                    //Execution en mode deconnecté
                    for (int i = 0; i <= Cles.Count - 1; i++)
                    {
                        cmd.Parameters.AddWithValue(Convert.ToString(Cles[i]), Valeurs[i]);
                    }

                    da.SelectCommand = cmd;
                    //Remplissage du dataset
                    da.Fill(ds);
                    return ds;

                }

            }

        }

        public static Boolean Verification_Code_kevin(String sTable, String sColonne, DateTime sValeur, String sColonne1, int sValeur1)
        {
            Boolean sResultat = false;
            using (SqlConnection cnx = new SqlConnection(Str()))
            {
                cnx.Open();
                String sCmd = String.Format("SELECT {0} FROM {1} WHERE {0}='{2}'  AND {3}='{4}' ", sColonne, sTable, sValeur, sColonne1, sValeur1);
                DataTable Dt = new DataTable();

                SqlCommand cmd = new SqlCommand(sCmd, cnx) { CommandType = CommandType.Text };
                SqlDataAdapter Da = new SqlDataAdapter(cmd);

                Da.Fill(Dt);
                if (Dt.Rows.Count > 0)
                {
                    sResultat = true;
                }
                else
                {
                    sResultat = false;
                }

            }
            return sResultat;

        }

        public static DataTable Extraction_ds(string SP, ArrayList Cles, ArrayList Valeurs, ref DataTable DT)
        {


            using (SqlConnection cnx = new SqlConnection(Str()))
            {

                using (SqlCommand cmd = new SqlCommand { CommandText = SP, CommandType = CommandType.StoredProcedure, Connection = cnx })
                {

                    // DataTable ds = new DataTable();
                    SqlDataAdapter da = new SqlDataAdapter();
                    //Execution en mode deconnecté
                    for (int i = 0; i <= Cles.Count - 1; i++)
                    {
                        cmd.Parameters.AddWithValue(Convert.ToString(Cles[i]), Valeurs[i]);
                    }

                    da.SelectCommand = cmd;
                    //Remplissage du dataset
                    da.Fill(DT);
                    return DT;


                }

            }

        }


        //-------------------------------------procedure  


        public static String Param(String sTable, String sColonne, Int32 sSite)
        {
            String sResultat = null;
            using (SqlConnection cnx = new SqlConnection(Str()))
            {
                cnx.Open();
                String sCmd = String.Format("SELECT {0} FROM {1} WHERE SITE_ID={2}", sColonne, sTable, sSite);
                DataTable Dt = new DataTable();

                SqlCommand cmd = new SqlCommand(sCmd, cnx) { CommandType = CommandType.Text };
                SqlDataAdapter Da = new SqlDataAdapter(cmd);

                Da.Fill(Dt);
                if (Dt.Rows.Count > 0)
                {
                    sResultat = Dt.Rows[0][0].ToString();
                }


            }
            return sResultat;


        }

        public static Int32 Recup_Typ_an(String sTable, String sColonne, Int32 sValeur, String sColonne1, Int32 sValeur1, String sValeurrecup)
        {
            String sCode = string.Empty;
            using (SqlConnection cnx = new SqlConnection(Str()))
            {
                cnx.Open();

                try
                {
                    string sCmd = String.Format("SELECT {5} FROM {1} WHERE {0}='{2}' AND {3}='{4}'", sColonne, sTable, sValeur, sColonne1, sValeur1, sValeurrecup);
                    DataTable Dt = new DataTable();

                    SqlCommand cmd = new SqlCommand(sCmd, cnx) { CommandType = CommandType.Text };
                    SqlDataAdapter Da = new SqlDataAdapter(cmd);
                    Da.Fill(Dt);
                    sCode = Dt.Rows[0][0].ToString();
                }
                catch (Exception ex)
                {
                    throw (ex);
                }
                finally
                {
                    cnx.Close();
                }

            }
            return Convert.ToInt32(sCode);


        }

        public static bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }

        //code 

        public static String Genere_Code(String Matricule, String sPrefixe)
        {
            string sNum = "";
            Int32 sVal = 0;
            string sZero = "";
            Random rndNumbers = new Random();
            int rndNumber = 0;

            rndNumber = rndNumbers.Next(0, 99999999);
            sVal = (rndNumber).ToString().Length;
            string n = DateTime.Today.Year.ToString();
            if (sVal > (8))
            {
                for (int i = 0; i < (8 - sVal); i++)
                {
                    sZero += "0";
                }
            }
            sNum = String.Format("{0}{1}{2}-{3}{4}", n.Substring(2), sPrefixe, Matricule, sZero, rndNumber);
            return sNum;
        }

        [MethodImpl(MethodImplOptions.NoInlining)]
        public static string GetCurrentMethod()
        {
            MethodBase m = MethodBase.GetCurrentMethod();
            return string.Format("Executing {0}.{1}", m.ReflectedType.Name, m.Name);
        }

        public static DataTable getLinkDetail(string idLien, string id_role)
        {
            DataTable dt = new DataTable();
            ArrayList cle = new ArrayList();
            ArrayList val = new ArrayList();

            cle.Add("@ID_LIENSOUSMENU"); val.Add(idLien);
            cle.Add("@ID_ROLE"); val.Add(id_role);
            cle.Add("@SENDER"); val.Add(4);

            Extraction_ds("PS_E_USERPROFILE", cle, val, ref dt);

            return dt;
        }

        public static void ControlsRight(string droit, ASPxMenu PageToolbar)
        {
            if (droit == Contants.Consultation)
            {
                PageToolbar.Items[1].Enabled = false;
                PageToolbar.Items[2].Enabled = false;
                PageToolbar.Items[3].Enabled = false;
            }
            else if (droit == Contants.creaModif)
            {
                PageToolbar.Items[3].Enabled = false;
            }
            //else if (droit == Contants.Suppression)
            //{
            //    PageToolbar.Items[1].Enabled = false;
            //    PageToolbar.Items[2].Enabled = false;
            //}
        }

        public static void ControlsRightDoc(string droit, ASPxMenu PageToolbar)
        {
            if (droit == Contants.Consultation)
            {
                PageToolbar.Items[1].Enabled = false;
                PageToolbar.Items[2].Enabled = false;
                PageToolbar.Items[3].Enabled = false;
                PageToolbar.Items[4].Enabled = false;
            }
            else if (droit == Contants.creaModif)
            {
                PageToolbar.Items[4].Enabled = false;
            }
            //else if (droit == Contants.Suppression)
            //{
            //    PageToolbar.Items[1].Enabled = false;
            //    PageToolbar.Items[2].Enabled = false;
            //}
        }

        public static string message_defini(string code_message)
        {
            DataTable dt = new DataTable();
            ArrayList cle = new ArrayList();
            ArrayList val = new ArrayList();

            cle.Add("@CODE_MESSAGE");
            val.Add(code_message);
            dt = Extraction_ds("PS_GLOBAL_MESSAGE", cle, val, ref dt);

            return dt.Rows[0][0].ToString();
        }



        public static string numerotation_document(string code_type_document, int site_id)
        {
            DataTable dt = new DataTable();
            ArrayList cle = new ArrayList();
            ArrayList val = new ArrayList();

            cle.Add("@Code");
            val.Add(code_type_document);
            cle.Add("@site_id");
            val.Add(site_id);
            dt = Extraction_ds("Generate_Numero", cle, val, ref dt);

            return dt.Rows[0][0].ToString();
        }

        public static void uploadFile(string module, string document, int doc_id, string source, ASPxUploadControl file)
        {
            /* const string UploadDirectory = "~/Document/" + module +"/";

             if (!string.IsNullOrEmpty(file.FileName) && file.IsValid)
             {
                 string resultExtension = Path.GetExtension(file.FileName);
                 string resultFileName = Path.ChangeExtension(Path.GetRandomFileName(), resultExtension);
                 string resultFileUrl = UploadDirectory + resultFileName;
                 string resultFilePath = MapPath(resultFileUrl);
                 file.SaveAs(resultFilePath);
                 string name = file.FileName;
                 string url = ResolveClientUrl(resultFileUrl);
                 long sizeInKilobytes = file.ContentLength / 1024;
                 string sizeText = sizeInKilobytes.ToString() + " KB";
                 result += name + "|" + url + "|" + sizeText + "&";
             }

             ArrayList cle = new ArrayList();
             ArrayList val = new ArrayList();

             cle.Add("@INDEX");
             val.Add("1");

             cle.Add("@ID");
             val.Add("0");

             cle.Add("@MOD");
             val.Add("stock");

             cle.Add("@LIB");
             val.Add(listBox.Items[i].Text);

             cle.Add("@TYP");
             val.Add("pro");

             cle.Add("@TID");
             val.Add(Session["achat"].ToString());

             cle.Add("@SOU");
             val.Add(listBox.Items[i].Value);

             cle.Add("@DAT");
             val.Add(DateTime.Now);

             cle.Add("@USE");
             val.Add(AuthHelper.GetLoggedInUserInfo().UserName.ToString());

             Cl_Fonction.Execute_Commande_StoreProc("PS_DOCUMENT", cle, val);*/
        }

        public static String Upload_Directory(string t, int site)
        {
            DataTable dt = new DataTable();
            ArrayList cle = new ArrayList();
            ArrayList val = new ArrayList();
            cle.Add("@TYPE");
            val.Add(t);
            cle.Add("@SITE_ID");
            val.Add(site);
            dt = Extraction_ds("PS_CHEMIN_UPLOAD", cle, val, ref dt);
            string Str = dt.Rows[0][0].ToString();
            if (Str == "CHEMIN NON DEFINI")
            {
                Str = "~/Document/";
            }
            return Str;
        }

        public static void ExtractFileToDataTable(byte[] bin, out DataTable dt)
        {
            //create a new Excel package in a memorystream
            using (MemoryStream stream = new MemoryStream(bin))
            using (ExcelPackage excelPackage = new ExcelPackage(stream))
            {
                dt = ExcelPackageToDataTable(excelPackage);
            }
        }

        public static DataTable ExcelPackageToDataTable(ExcelPackage excelPackage)
        {
            DataTable dt = new DataTable();
            ExcelWorksheet worksheet = excelPackage.Workbook.Worksheets[1];

            //check if the worksheet is completely empty
            if (worksheet.Dimension == null)
            {
                return dt;
            }

            //create a list to hold the column names
            List<string> columnNames = new List<string>();

            //needed to keep track of empty column headers
            int currentColumn = 1;

            //loop all columns in the sheet and add them to the datatable
            foreach (var cell in worksheet.Cells[1, 1, 1, worksheet.Dimension.End.Column])
            {
                string columnName = cell.Text.Trim();

                //check if the previous header was empty and add it if it was
                if (cell.Start.Column != currentColumn)
                {
                    columnNames.Add("Header_" + currentColumn);
                    dt.Columns.Add("Header_" + currentColumn);
                    currentColumn++;
                }

                //add the column name to the list to count the duplicates
                columnNames.Add(columnName);

                //count the duplicate column names and make them unique to avoid the exception
                ////A column named 'Name' already belongs to this DataTable
                //int occurrences = columnNames.Count;//.Count(x => x.Equals(columnName));
                //if (occurrences > 1)
                //{
                //    columnName = columnName + "_" + occurrences;
                //}

                //add the column to the datatable
                dt.Columns.Add(columnName);

                currentColumn++;
            }

            //start adding the contents of the excel file to the datatable
            for (int i = 2; i <= worksheet.Dimension.End.Row; i++)
            {
                var row = worksheet.Cells[i, 1, i, worksheet.Dimension.End.Column];
                DataRow newRow = dt.NewRow();

                //loop all cells in the row
                foreach (var cell in row)
                {
                    newRow[cell.Start.Column - 1] = cell.Text;
                }

                dt.Rows.Add(newRow);
            }

            return dt;
        }

        public static string ImportDataTableToDataBase(string nameTable, DataTable dt)
        {
            using (SqlConnection connection = new SqlConnection(Str()))
            {
                connection.Open();
                using (SqlBulkCopy bulkCopy = new SqlBulkCopy(connection))
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        foreach (DataColumn col in dt.Columns)
                        {
                            //if (row.IsNull(col) && col.DataType == typeof(string) && col.Caption != "NUM_CMPTE_TIERS" && col.Caption != "CMPTE_GLE" && col.Caption != "DATE_SAISIE")
                            if (row.IsNull(col) && col.DataType == typeof(string) && (col.Caption == "NUM_CMPTE_TIERS" || col.Caption == "CMPTE_GLE" || col.Caption == "CODE_JOURNAL"))
                                row.SetField(col, String.Empty);
                        }
                    }

                    foreach (DataColumn c in dt.Columns)
                        bulkCopy.ColumnMappings.Add(c.ColumnName, c.ColumnName);

                    bulkCopy.DestinationTableName = nameTable;

                    try
                    {
                        bulkCopy.WriteToServer(dt);
                        return ("Done");

                    }
                    catch (Exception ex)
                    {
                        return (ex.Message);
                    }
                }
            }
        }

        public static DataTable DataFromImport(int t)
        {
            DataTable dt = new DataTable();
            ArrayList cle = new ArrayList();
            ArrayList val = new ArrayList();
            cle.Add("@SENDER");
            val.Add(t);
            Extraction_ds("compta.PS_IMPORT", cle, val, ref dt);

            return dt;
        }


        public static void VentilationAuto(int id_linepiece, int section, Int64 debitaj, Int64 creditaj)
        {
            ArrayList cle = new ArrayList();
            ArrayList val = new ArrayList();

            cle.Add("@ID_LINEPIECE");
            val.Add(id_linepiece);

            cle.Add("@ID_SECTION");
            val.Add(section);

            cle.Add("@DEBIT");
            val.Add(debitaj);

            cle.Add("@CREDIT");
            val.Add(creditaj);

            cle.Add("@SENDER");
            val.Add(1);

            Cl_Fonction.Extraction_ds("compta.PS_SECTIONLINEPIECE", cle, val);

        }


        //public void ImageViaUploadControl(FileUploadCompleteEventArgs e, string resultFilePath, string url, string module, string index, string ID, string typ, string tid, string username, string date)
        //{
        //    string NumeroFichier = Path.GetRandomFileName();
        //    string UploadDirectory = "~/Document/" + module + "/";
        //    string resultExtension = Path.GetExtension(e.UploadedFile.FileName);
        //    string newname = Path.GetRandomFileName() + e.UploadedFile.FileName;
        //    string resultFileName = Path.ChangeExtension(newname, resultExtension);
        //    string resultFileUrl = UploadDirectory + resultFileName;
        //    string resultFilePath = MapPath(resultFileUrl);
        //    e.UploadedFile.SaveAs(resultFilePath);
        //    string name = e.UploadedFile.FileName;
        //    string url = ResolveClientUrl(resultFileUrl);
        //    long sizeInKilobytes = e.UploadedFile.ContentLength / 1024;
        //    string sizeText = sizeInKilobytes.ToString() + " KB";
        //    e.CallbackData = name + "|" + url + "|" + sizeText + "|" + NumeroFichier;
        //    //Enregistrer les url des fichiers dans la table Document   
        //    try
        //    {
        //        ArrayList cle = new ArrayList();
        //        ArrayList val = new ArrayList();
        //        cle.Add("@INDEX"); val.Add(index);
        //        cle.Add("@ID"); val.Add(ID);
        //        cle.Add("@MOD"); val.Add(module);
        //        cle.Add("@LIB"); val.Add(name.ToString());
        //        cle.Add("@DES"); val.Add(name.ToString());
        //        cle.Add("@TYP"); val.Add(typ);
        //        cle.Add("@TID"); val.Add(tid);
        //        cle.Add("@SOU"); val.Add(url.ToString());
        //        cle.Add("@USE"); val.Add(username);
        //        cle.Add("@DAT"); val.Add(date);

        //        Execute_Commande_StoreProc("PS_DOCUMENT", cle, val);
        //    }
        //    catch (Exception es)
        //    {
        //        string m = es.Message;
        //    }
        //}

    }
}