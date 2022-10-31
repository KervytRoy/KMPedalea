using KMPedalea.Server.Services;
using KMPedalea.Shared.Models;
using Microsoft.AspNetCore.Mvc;

namespace KMPedalea.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductosController : ControllerBase
    {
        private DBService _dbService = new DBService();        

        [HttpGet]
        public IEnumerable<Product> Get()
        {
            return _dbService.GetProducts();
        }
        [HttpGet("{id}")]
        public Product Get(int id)
        {
            return _dbService.GetProductsById(id);
        }
    }
}
