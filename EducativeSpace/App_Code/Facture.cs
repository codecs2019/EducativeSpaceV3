using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class Facture
{
    public DateTime DATE { set; get; }
    public string JOURNAL { set; get; }
    public string NUMERO { set; get; }
    public string REFERENCE { set; get; }
    public string NUMERO_TIER { set; get; }
    public int COMPTE { set; get; }
    public float CREDIT { set; get; }
    public float DEBIT { set; get; }
    public Facture()
    {
        
    }
}