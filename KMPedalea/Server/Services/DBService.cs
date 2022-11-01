using System.Data.SqlClient;
using KMPedalea.Shared.Models;
using System.Data;

namespace KMPedalea.Server.Services
{
    public class DBService : IDBService
    {
        private string connectionString = "Data Source=DESKTOP-FJBQ9H9; Initial Catalog=PedaleaDB; User=sa; Password=175390513";

        public List<Product> GetProducts()
        {
            List<Product> products = new List<Product>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("spConsultarProductos", connection);
                try
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        Product product = new Product();
                        product.Id = Int32.Parse(reader["id"].ToString());
                        product.Name = reader["name"].ToString();
                        product.Price = Decimal.Parse(reader["price"].ToString());
                        product.Image = reader["image"].ToString();
                        products.Add(product);
                    }
                    reader.Close();
                    connection.Close();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
            return products;
        }
        public Product GetProductsById(int id)
        {
            Product product = new Product();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("spConsultarProductoById", connection);
                command.Parameters.AddWithValue("@id", SqlDbType.Int).Value = id;
                try
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {                        
                        product.Id = Int32.Parse(reader["id"].ToString());
                        product.Name = reader["name"].ToString();
                        product.Price = Decimal.Parse(reader["price"].ToString());
                        product.Image = reader["image"].ToString();
                    }
                    reader.Close();
                    connection.Close();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
            return product;
        }

        public List<Pedido> GetPedidos()
        {
            List<Pedido> pedidos = new List<Pedido>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("spConsultarPedidos", connection);
                try
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        Pedido pedido = new Pedido();
                        pedido.Id = Int32.Parse(reader["id"].ToString());
                        pedido.Total = Decimal.Parse(reader["total"].ToString());
                        pedidos.Add(pedido);
                    }
                    reader.Close();
                    connection.Close();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
            return pedidos;
        }
        public List<DetallePedido> GetDetallesPedido(int idPedido)
        {
            List<DetallePedido> detallesPedido = new List<DetallePedido>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("spInnerJoinDetallesPedidoProductsByPedido", connection);
                command.Parameters.AddWithValue("@idPedido", SqlDbType.Int).Value = idPedido;
                try
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        DetallePedido detallePedido = new DetallePedido();
                        detallePedido.Id = Int32.Parse(reader["id"].ToString());
                        detallePedido.IdProducto = Int32.Parse(reader["idProducto"].ToString());
                        detallePedido.IdPedido = Int32.Parse(reader["idPedido"].ToString());
                        detallePedido.Cantidad = Int32.Parse(reader["amount"].ToString());
                        detallePedido.Total = Decimal.Parse(reader["total"].ToString());
                        detallePedido.NombreProducto = reader["name"].ToString();
                        detallesPedido.Add(detallePedido);
                    }
                    reader.Close();
                    connection.Close();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
            return detallesPedido;
        }

        public int AddPedido(decimal total)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("spCrearPedido", connection);
                command.Parameters.AddWithValue("@total", SqlDbType.Decimal).Value = total;

                try
                {
                    command.CommandType = CommandType.StoredProcedure;
                    connection.Open();
                    var reader = command.ExecuteReader();
                    int idInsert = 0;
                    while (reader.Read())
                    {
                        idInsert = (int)(reader.GetDecimal(0));
                    }
                    
                    reader.Close();
                    connection.Close();
                    return idInsert;
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }
        public int AddDetallesPedido(List<DetallePedido> detallesPedido)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                int inserts = 0;
                foreach (var detalle in detallesPedido)
                {
                    SqlCommand command = new SqlCommand("spCrearDetallePedido", connection);
                    command.Parameters.AddWithValue("@idPedido", SqlDbType.Decimal).Value = detalle.IdPedido;
                    command.Parameters.AddWithValue("@idProducto", SqlDbType.Decimal).Value = detalle.IdProducto;
                    command.Parameters.AddWithValue("@cantidad", SqlDbType.Decimal).Value = detalle.Cantidad;
                    command.Parameters.AddWithValue("@total", SqlDbType.Decimal).Value = detalle.Total;

                    try
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        connection.Open();
                        var response = command.ExecuteNonQuery();
                        inserts = response;
                        connection.Close();
                    }
                    catch (Exception e)
                    {
                        throw new Exception(e.Message);
                    }
                }
                return inserts;
            }
        }
        public void DeletePedido(int pedidoId)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("spEliminarPedido", connection);
                command.Parameters.AddWithValue("@id", SqlDbType.Decimal).Value = pedidoId;

                try
                {
                    command.CommandType = CommandType.StoredProcedure;
                    connection.Open();
                    var reader = command.ExecuteNonQuery();
                    connection.Close();
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
            }
        }

    }
}
