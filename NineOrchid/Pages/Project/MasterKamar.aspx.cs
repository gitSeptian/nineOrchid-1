using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using NineOrchidBLL;
using System.Data.SqlClient;
using System.Collections;
using System.IO;
using System.Xml;
using Newtonsoft.Json;

namespace NineOrchid.Pages.Project
{

    public partial class MasterKamar : System.Web.UI.Page
    {
        public string GridContent;
        ddlProject ddllist = new ddlProject();
        KamarBLL bll = new KamarBLL();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getddlGedung();
                GetData();
            }
            GetData();
        }

        protected void UploadButton_Click(object sender, EventArgs e)
        {

        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            var checkBoxAC = CheckBoxAC.Checked;
            try
            {
                SortedList sl = new SortedList();
                var foto1 = ImageUpload(FileUpload1);
                var foto2 = ImageUpload(FileUpload2);
                var foto3 = ImageUpload(FileUpload3);
                var foto4 = ImageUpload(FileUpload4);
                var foto5 = ImageUpload(FileUpload5);

                sl.Add("@idxGedung-INT", DdlGedungList.SelectedValue);
                sl.Add("@no_kamar-VARCHAR-3", no_kamar.Text);
                sl.Add("@lantai_kmr-VARCHAR-3", lantai_kmr.Text);
                sl.Add("@kategori_kmr-VARCHAR-20", KategoriKamar.Text);
                sl.Add("@peruntukan-VARCHAR-10", peruntukanddl.SelectedValue);
                sl.Add("@isAC-bit", CheckBoxAC.Checked);
                sl.Add("@isTV-bit", CheckBoxTV.Checked);
                sl.Add("@trf_harian-VARCHAR-50", trf_harian.Text);
                sl.Add("@trf_bulanan-VARCHAR-50", trf_bulanan.Text);
                sl.Add("@trf_tiga_bulanan-VARCHAR-50", trf_tiga_bulanan.Text);
                sl.Add("@ket-VARCHAR-50", ket.Text);
                sl.Add("@foto1-image", foto1);
                sl.Add("@foto2-image", foto2);
                sl.Add("@foto3-image", foto3);
                sl.Add("@foto4-image", foto4);
                sl.Add("@foto5-image", foto5);

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
        protected SortedList Image()
        {
            FileUpload[] arrayFile = { FileUpload1, FileUpload2, FileUpload3, FileUpload4, FileUpload5, };
            SortedList fileBunch = new SortedList();
            int index = 0;
            int indexImage = 0;
            foreach (var item in arrayFile)
            {
                if (arrayFile[index].HasFile)
                {
                    fileBunch.Add(indexImage, ImageUpload(arrayFile[index]));
                    indexImage++;
                }
                index++;
            }

            return fileBunch;
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
        protected void SuccessAction()
        {

            panelInfo.Visible = true;
            infolbl.Text = "success melakukan update data!";
            clearForm();
            GetData();

        }
        public void clearForm()
        {
            no_kamar.Text = "";
            lantai_kmr.Text = "";
            trf_harian.Text = "";
            trf_bulanan.Text = "";
            trf_tiga_bulanan.Text = "";
            ket.Text = "";
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
        public byte[] ImageUpload(FileUpload imageContent)
        {
            if (imageContent.HasFile)
            {
                int imagefileLen = imageContent.PostedFile.ContentLength;
                byte[] imgarray = new byte[imagefileLen];
                HttpPostedFile image = imageContent.PostedFile;
                image.InputStream.Read(imgarray, 0, imagefileLen);
                return imgarray;

            }
            return null;
        }

    }
}