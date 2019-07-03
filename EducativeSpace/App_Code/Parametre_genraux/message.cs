using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Description résumée de message
/// </summary>
public class message
{
    public message()
    {
        //
        // TODO: Add constructor logic here
        //
        
    }
    public enum CodeMessage
    {
        SUCCES,
        DELETE_SUCCES,
        UPDATE_SUCCES,
        ECHEC,
        EXISTING_RECORDING,
        UNEXPECTED_ERROR,
        RECORD_NOT_FOUND,
        NO_AUTHORIZATION,
        INCORRECT_CODE,
        ALREADY_ACTIVED
    }
}