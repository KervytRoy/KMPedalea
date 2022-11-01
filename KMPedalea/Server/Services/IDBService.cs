using KMPedalea.Shared.Models;

namespace KMPedalea.Server.Services
{
    public interface IDBService
    {
        int AddDetallesPedido(List<DetallePedido> detallesPedido);
        int AddPedido(decimal total);
        void DeletePedido(int pedidoId);
        List<DetallePedido> GetDetallesPedido(int idPedido);
        List<Pedido> GetPedidos();
        List<Product> GetProducts();
        Product GetProductsById(int id);
    }
}