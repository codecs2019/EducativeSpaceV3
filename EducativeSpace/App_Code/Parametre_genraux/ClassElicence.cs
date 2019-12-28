using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Description résumée de ClassElicence
/// </summary>
public class ClassElicence
{
    public ClassElicence()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public class Table
    {
        public int E_PACK_ID { get; set; }
        public string E_PACK_LIBELLE { get; set; }
        public string E_PACK_CODE { get; set; }
        public int ID_PROJET { get; set; }
        public int IDPROJET { get; set; }
        public string CODE_PROJET { get; set; }
        public string LIBELLE_PROJET { get; set; }
    }

    public class RootObjectPack
    {
        public List<Table> Table { get; set; }
    }
}