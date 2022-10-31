using KMPedalea.Server.Services;
using KMPedalea.Shared.Models;
using Microsoft.AspNetCore.Mvc;

namespace KMPedalea.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DetallesPedidoController : ControllerBase
    {
        private DBService _dbService = new DBService();

        [HttpGet("{pedidoId}")]
        public IEnumerable<DetallePedido> Get(int pedidoId)
        {
            return _dbService.GetDetallesPedido(pedidoId);
        }
        
    }
}
