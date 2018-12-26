using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Configuration;

namespace NinceOrchidDAL
{
    public class NineOrchidDAL
    {
        SqlConnection conn;
        String strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();


        public void ExecNonQuery(string sp, SortedList sl)
        {
            if (conn == null)
            {
                conn = new SqlConnection(strCon);
            }
            try
            {
                conn.Open();
                SqlCommand cmn = new SqlCommand(sp, conn);
                cmn.CommandType = CommandType.StoredProcedure;

                foreach (DictionaryEntry entry in sl)
                {
                    string[] temp = entry.Key.ToString().Split('-');
                    if (temp[1].ToLower() == "varchar")
                    {
                        cmn.Parameters.Add(temp[0].ToString(), SqlDbType.VarChar, int.Parse(temp[2])).Value = entry.Value;
                    }
                    else if (temp[1].ToLower() == "int")
                    {
                        cmn.Parameters.Add(temp[0].ToString(), SqlDbType.Int).Value = int.Parse(entry.Value.ToString());
                    }
                    else if (temp[1].ToLower() == "date")
                    {
                        cmn.Parameters.Add(temp[0].ToString(), SqlDbType.Date).Value = entry.Value;
                    }
                    else if (temp[1].ToLower() == "datetime")
                    {
                        cmn.Parameters.Add(temp[0].ToString(), SqlDbType.DateTime).Value = entry.Value;
                    }
                    else if (temp[1].ToLower() == "bit")
                    {
                        cmn.Parameters.Add(temp[0].ToString(), SqlDbType.Bit).Value = entry.Value;
                    }
                    else if (temp[1].ToLower() == "varbinary")
                    {
                        cmn.Parameters.Add(temp[0].ToString(), SqlDbType.VarBinary).Value = entry.Value;
                    }
                }
                cmn.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
        }
        public DataTable GetData(string sp, SortedList Is)
        {
            DataTable dt = new DataTable("data");
            if (conn == null)
            {
                conn = new SqlConnection(strCon);
            }
            try
            {
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(sp, conn);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;

                foreach (DictionaryEntry entry in Is)
                {
                    string[] temp = entry.Key.ToString().Split('-');
                    if (temp[1].ToLower() == "varchar")
                    {
                        da.SelectCommand.Parameters.Add(temp[0].ToString(), SqlDbType.VarChar, int.Parse(temp[2])).Value = entry.Value;
                    }
                    else if (temp[1].ToLower() == "int")
                    {
                        da.SelectCommand.Parameters.Add(temp[0].ToString(), SqlDbType.Int).Value = int.Parse(entry.Value.ToString());
                    }
                    else if (temp[1].ToLower() == "date")
                    {
                        da.SelectCommand.Parameters.Add(temp[0].ToString(), SqlDbType.Date).Value = entry.Value;
                    }
                    else if (temp[1].ToLower() == "datetime")
                    {
                        da.SelectCommand.Parameters.Add(temp[0].ToString(), SqlDbType.DateTime).Value = entry.Value;
                    }
                    else if (temp[1].ToLower() == "time")
                    {
                        da.SelectCommand.Parameters.Add(temp[0].ToString(), SqlDbType.Time).Value = entry.Value;
                    }
                    else if (temp[1].ToLower() == "bit")
                    {
                        da.SelectCommand.Parameters.Add(temp[0].ToString(), SqlDbType.Bit).Value = entry.Value;
                    }
                    else if (temp[1].ToLower() == "varbinary")
                    {
                        da.SelectCommand.Parameters.Add(temp[0].ToString(), SqlDbType.VarBinary).Value = entry.Value;
                    }
                }
                da.Fill(dt);

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
            return dt;
        }
    }
}
