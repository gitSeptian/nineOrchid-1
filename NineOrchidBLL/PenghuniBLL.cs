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
    public class PenghuniBLL
    {
        NineOrchidDAL sqlDal = new NineOrchidDAL();
        public DataTable GetContent(SortedList sl)
        {
            return sqlDal.GetData("[stp_get_penghuni]", sl);
        }
        public void Insert(SortedList sl)
        {
            sqlDal.ExecNonQuery("[stp_insert_penghuni]", sl);
        }
        public void Delete(SortedList sl)
        {
            sqlDal.ExecNonQuery("[stp_delete_penghuni]", sl);
        }
        public void Update(SortedList sl)
        {
            sqlDal.ExecNonQuery("[stp_update_penghuni]", sl);
        }
    }
}
