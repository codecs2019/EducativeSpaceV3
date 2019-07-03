using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;

[HubName("notification")]
public class NotificationHub : Hub
{
    public static void Show()
    {
        IHubContext context = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
        context.Clients.All.displayStatus();
    }
    /**
    //Logged Use Call  
    public void GetNotification()
    {
        try
        {
            string loggedUser = Context.User.Identity.Name;

            //Get TotalNotification  
            string totalNotif = LoadNotifData(loggedUser);

            //Send To  
            if (Users.TryGetValue(loggedUser, out receiver))
            {
                var cid = receiver.ConnectionIds.FirstOrDefault();
                var context = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
                context.Clients.Client(cid).broadcaastNotif(totalNotif);
            }
        }
        catch (Exception ex)
        {
            ex.ToString();
        }
    }

    //Specific User Call  
    public void SendNotification(string SentTo)
    {
        try
        {
            //Get TotalNotification  
            string totalNotif = LoadNotifData(SentTo);

            //Send To  
            if (Users.TryGetValue(SentTo, out receiver))
            {
                var cid = receiver.ConnectionIds.FirstOrDefault();
                var context = GlobalHost.ConnectionManager.GetHubContext<NotificationHub>();
                context.Clients.Client(cid).broadcaastNotif(totalNotif);
            }
        }
        catch (Exception ex)
        {
            ex.ToString();
        }
    }

    private string LoadNotifData(string userId)
    {
        int total = 0;

        return total.ToString();
    }
    **/
}
