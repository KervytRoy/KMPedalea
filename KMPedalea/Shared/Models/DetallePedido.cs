using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace KMPedalea.Shared.Models
{
    public class DetallePedido
    {
        public int Id { get; set; }
        public int IdPedido { get; set; }
        public int IdProducto { get; set; }
        public string NombreProducto { get; set; }
        public decimal Total { get; set; }
        public int Cantidad { get; set; }
    }
}
