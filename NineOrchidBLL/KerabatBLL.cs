using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NinceOrchidDAL;
using System.Data;
using System.Collections;

namespace NineOrchidBLL
{
    public class KerabatBLL
    {
        NineOrchidDAL sqlDal = new NineOrchidDAL();
        public DataTable GetContent(SortedList sl)
        {
            return  sqlDal.GetData("[stp_get_kerabat]", sl);
        }
        public void Insert(SortedList sl)
        {
            sqlDal.ExecNonQuery("[stp_insert_kerabat]", sl);
        }
        public void Delete(SortedList sl)
        {
            sqlDal.ExecNonQuery("[stp_delete_kerabat]", sl);
        }
        public void Update(SortedList sl)
        {
            sqlDal.ExecNonQuery("[stp_update_kerabat]", sl);
        }
    }
}
