using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NineOrchidBLL;

namespace NineOrchid.Pages.Project
{
    public partial class BookingKamar : System.Web.UI.Page
    {
        ddlProject ddllist = new ddlProject();
        KamarBLL kamarBLL = new KamarBLL();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getddlGedung();
            }
    
          
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

        }
        protected void getddlGedung()
        {
            SortedList sl = new SortedList();
            sl.Add("@jenisddl-INT", 1);

            DataTable dt = ddllist.GetDdl(sl);
            DdlGedungList.DataSource = dt;
            DdlGedungList.DataValueField = "Key_value";
            DdlGedungList.DataTextField = "Key_text";
            DdlGedungList.DataBind();
        }

        protected void getddlKamar()
        {
            SortedList sl = new SortedList();
            sl.Add("@jenisddl-INT", 3);
            sl.Add("@param-varchar-5", DdlGedungList.SelectedValue);
            DataTable dt = ddllist.GetDdl(sl);
            ddlKamar.DataSource = dt;
            ddlKamar.DataValueField = "Key_value";
            ddlKamar.DataTextField = "Key_text";
            ddlKamar.DataBind();
        }

        protected void DdlGedungList_SelectedIndexChanged(object sender, EventArgs e)
        {
            getddlKamar();
        }

        protected void checkHarga_CheckedChanged(object sender, EventArgs e)
        {
            SortedList sl = new SortedList();
            sl.Add("@idxKamar-varchar-10", ddlKamar.SelectedValue);
            DataTable dt = kamarBLL.GetContent(sl);
            cost_deal.Text = dt.Rows[0]["trf_bulanan"].ToString();
        }
    }
}