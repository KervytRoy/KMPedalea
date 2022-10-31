using KMPedalea.Server.Services;
using KMPedalea.Shared.Models;
using Microsoft.AspNetCore.Mvc;

namespace KMPedalea.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PedidosController : ControllerBase
    {
        private DBService _dbService = new DBService();
        
        [HttpGet]
        public IEnumerable<Pedido> Get()
        {
            return _dbService.GetPedidos();
        }        
        [HttpPost]
        public int Post([FromBody] decimal total)
        {
            int idPedido;
            idPedido = _dbService.AddPedido(total);
            return idPedido;
        }
        [HttpPost("detalle")]
        public void PostDetalle([FromBody] List<DetallePedido> detalles)
        {
            _dbService.AddDetallesPedido(detalles);
        }
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
            _dbService.DeletePedido(id);
        }
    }
}
