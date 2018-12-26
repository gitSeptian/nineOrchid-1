using NinceOrchidDAL;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NineOrchidBLL
{
    public class ddlProject
    {

        NineOrchidDAL sqlDal = new NineOrchidDAL();
        public DataTable GetDdl(SortedList sl)
        {
            return sqlDal.GetData("[stp_get_ddl]", sl);
        }
    }
}
