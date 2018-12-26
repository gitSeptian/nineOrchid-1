﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NineOrchidBLL;
using System.Collections;
using System.Data;
using System.IO;
using System.Xml;
using Newtonsoft.Json;

namespace NineOrchid.Pages.Project
{
    public partial class MasterPerusahaan : System.Web.UI.Page
    {
        PerusahaanBLL bll = new PerusahaanBLL();
        public string GridContent;
        protected void Page_Load(object sender, EventArgs e)
        {
            GetData();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                SortedList sl = new SortedList();
                sl.Add("@nm_perusahaan-varchar-50", nmperusahaan.Text);
                sl.Add("@almt_perusahaan-varchar-200", almt_perusahaan.Text);
                sl.Add("@kota_perusahaan-varchar-20", kota_perusahaan.Text);
                sl.Add("@telp_perusahaan-varchar-20", telp_perusahaan.Text);
                bll.Insert(sl);
                SuccessAction();

            }
            catch (Exception ex)
            {
                infolbl.Text = ex.ToString();
                panelInfo.CssClass = "alert alert-danger";
                throw;
            }


        }
        protected void SuccessAction()
        {
            panelInfo.Visible = true;
            infolbl.Text = "success melakukan update data!";
            nmperusahaan.Text = "";
            almt_perusahaan.Text = "";
            kota_perusahaan.Text = "";
            telp_perusahaan.Text = "";
        }
        public void GetData()
        {
            DataTable dt = new DataTable("data");
            SortedList sl = new SortedList();
            dt = bll.GetContent(sl);
            string hasil;
            using (StringWriter sw = new StringWriter())
            {
                dt.WriteXml(sw);
                hasil = sw.ToString();
            }

            XmlDocument doc = new XmlDocument();
            doc.LoadXml(hasil);
            string content = JsonConvert.SerializeXmlNode(doc);
            GridContent = content;
        }
    }
}
