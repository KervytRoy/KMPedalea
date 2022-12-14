USE [PedaleaDB]
GO
/****** Object:  Table [dbo].[DetallePedido]    Script Date: 31/10/2022 10:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetallePedido](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idpedido] [int] NOT NULL,
	[idproducto] [int] NOT NULL,
	[amount] [int] NOT NULL,
	[total] [int] NOT NULL,
 CONSTRAINT [PK_DetallePedido] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pedidos]    Script Date: 31/10/2022 10:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedidos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[total] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Pedidos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 31/10/2022 10:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[price] [decimal](18, 2) NOT NULL,
	[image] [varchar](200) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[DetallePedido] ON 

INSERT [dbo].[DetallePedido] ([id], [idpedido], [idproducto], [amount], [total]) VALUES (15, 22, 1, 1, 200)
INSERT [dbo].[DetallePedido] ([id], [idpedido], [idproducto], [amount], [total]) VALUES (16, 22, 2, 1, 300)
INSERT [dbo].[DetallePedido] ([id], [idpedido], [idproducto], [amount], [total]) VALUES (17, 22, 6, 2, 550)
INSERT [dbo].[DetallePedido] ([id], [idpedido], [idproducto], [amount], [total]) VALUES (20, 25, 4, 2, 500)
INSERT [dbo].[DetallePedido] ([id], [idpedido], [idproducto], [amount], [total]) VALUES (21, 25, 1, 3, 600)
INSERT [dbo].[DetallePedido] ([id], [idpedido], [idproducto], [amount], [total]) VALUES (22, 25, 2, 3, 900)
INSERT [dbo].[DetallePedido] ([id], [idpedido], [idproducto], [amount], [total]) VALUES (23, 25, 3, 1, 400)
SET IDENTITY_INSERT [dbo].[DetallePedido] OFF
GO
SET IDENTITY_INSERT [dbo].[Pedidos] ON 

INSERT [dbo].[Pedidos] ([id], [total]) VALUES (22, CAST(1050.00 AS Decimal(18, 2)))
INSERT [dbo].[Pedidos] ([id], [total]) VALUES (25, CAST(2400.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Pedidos] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([id], [name], [price], [image]) VALUES (1, N'NikeOne', CAST(200.00 AS Decimal(18, 2)), N'1')
INSERT [dbo].[Products] ([id], [name], [price], [image]) VALUES (2, N'NikeRTT', CAST(300.00 AS Decimal(18, 2)), N'2')
INSERT [dbo].[Products] ([id], [name], [price], [image]) VALUES (3, N'NikeAlfa', CAST(400.00 AS Decimal(18, 2)), N'3')
INSERT [dbo].[Products] ([id], [name], [price], [image]) VALUES (4, N'NikeBlind', CAST(250.00 AS Decimal(18, 2)), N'4')
INSERT [dbo].[Products] ([id], [name], [price], [image]) VALUES (5, N'NikeTTT', CAST(350.00 AS Decimal(18, 2)), N'5')
INSERT [dbo].[Products] ([id], [name], [price], [image]) VALUES (6, N'NikeVex', CAST(275.00 AS Decimal(18, 2)), N'6')
INSERT [dbo].[Products] ([id], [name], [price], [image]) VALUES (7, N'NikeTEM', CAST(356.00 AS Decimal(18, 2)), N'7')
INSERT [dbo].[Products] ([id], [name], [price], [image]) VALUES (8, N'NikeSIX', CAST(248.00 AS Decimal(18, 2)), N'8')
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
ALTER TABLE [dbo].[DetallePedido]  WITH CHECK ADD  CONSTRAINT [FK_DetallePedido_Pedidos] FOREIGN KEY([idpedido])
REFERENCES [dbo].[Pedidos] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DetallePedido] CHECK CONSTRAINT [FK_DetallePedido_Pedidos]
GO
ALTER TABLE [dbo].[DetallePedido]  WITH CHECK ADD  CONSTRAINT [FK_DetallePedido_Products] FOREIGN KEY([idproducto])
REFERENCES [dbo].[Products] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DetallePedido] CHECK CONSTRAINT [FK_DetallePedido_Products]
GO
/****** Object:  StoredProcedure [dbo].[spConsultarDetallesPedidoById]    Script Date: 31/10/2022 10:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spConsultarDetallesPedidoById]
@idPedido INT
AS
BEGIN
SELECT * FROM DetallePedido WHERE idpedido = @idPedido
END
GO
/****** Object:  StoredProcedure [dbo].[spConsultarPedidos]    Script Date: 31/10/2022 10:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spConsultarPedidos]
AS
BEGIN
Select * from Pedidos
END
GO
/****** Object:  StoredProcedure [dbo].[spConsultarProductoById]    Script Date: 31/10/2022 10:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spConsultarProductoById]
@id int
AS
BEGIN
Select * from Products where id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[spConsultarProductos]    Script Date: 31/10/2022 10:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spConsultarProductos]
AS
BEGIN
	SELECT * FROM Products
END
GO
/****** Object:  StoredProcedure [dbo].[spCrearDetallePedido]    Script Date: 31/10/2022 10:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCrearDetallePedido]
@idPedido int, 
@idProducto int,
@cantidad int,
@total int
AS
BEGIN
INSERT INTO DetallePedido([idpedido],[idproducto], [amount], [total])
VALUES (@idPedido, @idProducto, @cantidad, @total) 
END
GO
/****** Object:  StoredProcedure [dbo].[spCrearPedido]    Script Date: 31/10/2022 10:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCrearPedido]
@total DECIMAL(18,2)
AS 
INSERT INTO Pedidos([Total])
VALUES (@total) 
SELECT SCOPE_IDENTITY()
GO
/****** Object:  StoredProcedure [dbo].[spEliminarPedido]    Script Date: 31/10/2022 10:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spEliminarPedido]
@id INT
AS
BEGIN
DELETE FROM Pedidos WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[spInnerJoinDetallesPedidoProductsByPedido]    Script Date: 31/10/2022 10:28:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spInnerJoinDetallesPedidoProductsByPedido]
@idPedido int
AS
BEGIN
SELECT * FROM DetallePedido INNER JOIN Products ON DetallePedido.idproducto = Products.id where DetallePedido.idpedido = @idPedido;
END
GO
