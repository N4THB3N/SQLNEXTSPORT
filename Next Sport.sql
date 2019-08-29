CREATE DATABASE NEXTSPORT2013327
go 

USE NEXTSPORT2013327
go 

CREATE TABLE Categorias
(
	descripcion			VARCHAR(50) NOT NULL,
	codigoCategoria		INT NOT NULL IDENTITY(1,1) PRIMARY KEY 
)
go
/*          Agregar Categorias           */
	CREATE PROCEDURE sp_AgregarCategoria @descripcion VARCHAR(50) 
	AS 
			INSERT INTO Categorias (descripcion)
				VALUES (@descripcion)
go

/*			Actualizar Categorias		*/
	CREATE PROCEDURE sp_ActualizarCategoria  @codigoCategoria INT, @descripcion VARCHAR(50)
	AS 
			UPDATE Categorias SET descripcion = @descripcion WHERE codigoCategoria = @codigoCategoria
go 


/*			Listar Categorias			*/
	CREATE PROCEDURE sp_ListarCategoria 
	AS 
			SELECT Categorias.descripcion, Categorias.codigoCategoria FROM Categorias 
go

/*			Buscar Categoria			*/ 
	CREATE PROCEDURE sp_BuscarCategoria @codigoCategoria INT
	AS 
			SELECT Categorias.descripcion, Categorias.codigoCategoria 
				FROM Categorias WHERE codigoCategoria = @codigoCategoria
go

/*			Eliminar Categoria por codigo	*/ 
	CREATE PROCEDURE sp_EliminarCategoria @codigoCategoria INT 
	AS 
			DELETE FROM Categorias WHERE codigoCategoria = @codigoCategoria
go

CREATE TABLE Marcas 
(
	codigoMarca			INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
	descripcion			VARCHAR(50) NOT NULL  
)
go

/*			Agregar Marca			*/

	CREATE PROCEDURE sp_AgregarMarca @descripcion VARCHAR(50)
	AS 
			INSERT INTO Marcas(descripcion) VALUES(@descripcion)
go

/*			Listar Marcas			*/ 

	CREATE PROCEDURE sp_ListarMarcas
	AS 
			SELECT Marcas.codigoMarca, Marcas.descripcion 
				FROM Marcas 
go

/*			Buscar Marcas			*/

	CREATE PROCEDURE sp_BuscarMarcas @codigoMarca INT 
	AS 
			SELECT Marcas.descripcion, Marcas.codigoMarca
				FROM Marcas WHERE codigoMarca = @codigoMarca
go

/*			Actualizar Marca		*/

	CREATE PROCEDURE sp_ActualizarMarca @codigoMarca INT, @descripcion VARCHAR(60)
	AS 
			UPDATE Marcas SET descripcion = @descripcion WHERE codigoMarca = @codigoMarca 
go
/*			Eliminar Marca			*/

	CREATE PROCEDURE sp_EliminarMarca @codigoMarca INT 
	AS 
			DELETE FROM Marcas WHERE codigoMarca = @codigoMarca 
go

CREATE TABLE Tallas
(
	codigoTalla			INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	descripcion			VARCHAR (50) NOT NULL
)
go

/*				Agregar Tallas				*/

	CREATE PROCEDURE sp_AgregarTalla @descripcion VARCHAR(70) 
	AS 
			INSERT INTO Tallas(descripcion) VALUES(@descripcion)
go

/*				Listar Tallas				*/ 

	CREATE PROCEDURE sp_ListarTalla 
	AS 
			SELECT Tallas.codigoTalla, Tallas.descripcion FROM Tallas 
go

/*				Actualizar Talla			*/

	CREATE PROCEDURE sp_ActualizarTalla @codigoTalla INT, @descripcion VARCHAR(100) 
	AS 
			UPDATE Tallas SET descripcion = @descripcion WHERE codigoTalla = @codigoTalla
go

/*				Buscar Talla				*/

	CREATE PROCEDURE sp_BuscarTalla @codigoTalla INT 
	AS 
			SELECT Tallas.codigoTalla, Tallas.descripcion FROM Tallas 
				WHERE Tallas.codigoTalla = @codigoTalla
go

/*				Eliminar Talla				*/

		CREATE PROCEDURE sp_EliminarTalla @codigoTalla INT 
		AS 
				DELETE FROM Tallas WHERE codigoTalla = @codigoTalla 
go

CREATE TABLE Proveedores
(
	codigoProveedor			INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	paginaWeb				VARCHAR(50) NOT NULL, 
	contactoPrincipal		VARCHAR(50) NOT NULL, 
	razonSocial				VARCHAR(80) NOT NULL, 
	nit						VARCHAR(100) NOT NULL, 
	direccion				VARCHAR(50) NOT NULL
)
go
/*				Agregar Proveedores				*/

		CREATE PROCEDURE sp_AgregarProveedor @paginaWeb VARCHAR(50), @contactoPrincipal VARCHAR(50), 
							@razonSocial VARCHAR(80), @nit VARCHAR(100), @direccion VARCHAR(50) 
		AS 
					INSERT INTO Proveedores(paginaWeb, contactoPrincipal, razonSocial, nit, direccion)
						VALUES(@paginaWeb, @contactoPrincipal, @razonSocial, @nit, @direccion)
go  

/*				Listar Proveedores				*/

		CREATE PROCEDURE sp_ListarProveedores 
		AS 
					SELECT Proveedores.codigoProveedor, Proveedores.paginaWeb, Proveedores.contactoPrincipal, Proveedores.razonSocial,
							Proveedores.nit, Proveedores.direccion FROM Proveedores
go 
/*				Actualizar Proveedor			*/

		CREATE PROCEDURE sp_ActualizarProveedor  @codigoProveedor INT, @nit varchar(100) 
		AS 
				UPDATE Proveedores SET nit = @nit WHERE codigoProveedor = @codigoProveedor
go
/*				Buscar Proveedores				*/

		CREATE PROCEDURE sp_BuscarProveedor @codigoProveedor INT 
		AS 
				SELECT Proveedores.codigoProveedor, Proveedores.paginaWeb, Proveedores.contactoPrincipal,
						Proveedores.razonSocial, Proveedores.nit, Proveedores.direccion FROM 
							Proveedores WHERE Proveedores.codigoProveedor = @codigoProveedor
go 
/*				Eliminar Proveedores			*/

		CREATE PROCEDURE sp_EliminarProveedor @codigoProveedor INT 
		AS 
				DELETE FROM Proveedores WHERE codigoProveedor = @codigoProveedor
go
CREATE TABLE Productos
(
	codigoProducto		INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	codigoCategoria		INT NOT NULL, 
	codigoMarca			INT NOT NULL, 
	codigoTalla			INT NOT NULL, 
	existencia			INT, 
	precioDocena		DECIMAL (10,2) NOT NULL DEFAULT(0.00), 
	precioUnitario		DECIMAL (10,2) NOT NULL DEFAULT(0.00), 
	imagen				VARCHAR(100) NOT NULL,
	descripcion			VARCHAR(100) NOT NULL,
	precioMayor			DECIMAL(10,2) NOT NULL DEFAULT(0.00)
	
		CONSTRAINT FK_Productos_Categorias FOREIGN KEY (codigoCategoria)
			REFERENCES Categorias(codigoCategoria), 
		CONSTRAINT FK_Productos_Marcas FOREIGN KEY (codigoMarca)
			REFERENCES Marcas(codigoMarca), 
		CONSTRAINT FK_Productos_Tallas FOREIGN KEY (codigoTalla)
			REFERENCES Tallas(codigoTalla) 
)
go
/*					Agregar Productos				*/

			CREATE PROCEDURE sp_AgregarProductos 
				@codigoCategoria INT, @codigoMarca INT, @codigoTalla INT,
				 @imagen VARCHAR(50), @descripcion VARCHAR(100)
			AS 
					INSERT INTO Productos(codigoCategoria, codigoMarca, codigoTalla, imagen, descripcion)
						VALUES(@codigoCategoria, @codigoMarca, @codigoTalla, @imagen, @descripcion)
go
/*				Listar Productos				*/
			CREATE PROCEDURE sp_ListarProductos
			AS 
				SELECT Productos.codigoProducto, Productos.existencia, Productos.precioUnitario,  Productos.precioDocena, Productos.imagen, 
				Categorias.codigoCategoria, Categorias.descripcion as Categoria, Marcas.codigoMarca, Marcas.descripcion as Marca, Tallas.codigoTalla,
				  Tallas.descripcion as Talla, Productos.descripcion, Productos.precioMayor
					FROM Productos INNER JOIN Categorias on Productos.codigoCategoria = Categorias.codigoCategoria
									INNER JOIN Marcas on Productos.codigoMarca = Marcas.codigoMarca
									INNER JOIN Tallas on Productos.codigoTalla = Tallas.codigoTalla 
go
/*				Actualizar Productos			*/
			CREATE PROCEDURE sp_ActualizarProductos @codigoProducto INT, @descripcion VARCHAR(100)
			AS 
				UPDATE Productos SET descripcion = @descripcion  WHERE codigoProducto = @codigoProducto
go 
/*			Buscar Producto por codigo			*/
		CREATE PROCEDURE sp_BuscarProducto @codigoProducto INT 
		AS 
			SELECT Productos.codigoProducto, Productos.existencia, Productos.precioUnitario,  Productos.precioDocena, Productos.imagen, 
				Categorias.codigoCategoria, Categorias.descripcion as Categoria, Marcas.codigoMarca, Marcas.descripcion as Marca, Tallas.codigoTalla,
				  Tallas.descripcion as Talla, Productos.descripcion, Productos.precioMayor
					FROM Productos INNER JOIN Categorias on Productos.codigoCategoria = Categorias.codigoCategoria
									INNER JOIN Marcas on Productos.codigoMarca = Marcas.codigoMarca
									INNER JOIN Tallas on Productos.codigoTalla = Tallas.codigoTalla
					WHERE codigoProducto = @codigoProducto
go
/*				Eliminar Producto				*/ 
		CREATE PROCEDURE sp_EliminarProducto @codigoProducto INT 
		AS 
			DELETE FROM Productos WHERE codigoProducto = @codigoProducto
go
CREATE TABLE Compras
(
	numeroDocumento			INT NOT NULL IDENTITY (1,1) PRIMARY KEY ,
	codigoProveedor			INT NOT NULL,
	total					DECIMAL(10,2) DEFAULT(0.00),
	fecha					DATETIME NOT NULL,
	descripcion				VARCHAR(100) NOT NULL,
	
		CONSTRAINT FK_Compras_Proveedores FOREIGN KEY (codigoProveedor)
			REFERENCES Proveedores(codigoProveedor),		
)

go
/*					Agregar Compra					*/
			CREATE PROCEDURE sp_AgregarCompra @codigoProveedor INT,  @fecha DATETIME,
												@descripcion VARCHAR(100)
			AS
					INSERT INTO Compras(codigoProveedor, fecha, descripcion)
							VALUES(@codigoProveedor, @fecha, @descripcion) 
 
go
/*					Listar Compras					*/

			CREATE PROCEDURE sp_ListarCompras
			AS 
					SELECT Compras.numeroDocumento, Proveedores.codigoProveedor, Compras.total, Compras.fecha, Compras.descripcion, Proveedores.paginaWeb,
							Proveedores.contactoPrincipal, Proveedores.razonSocial, Proveedores.nit, Proveedores.direccion
							FROM Compras INNER JOIN Proveedores
								ON Compras.codigoProveedor = Proveedores.codigoProveedor
								
go
			CREATE PROCEDURE sp_ListarCompra @numeroDocumento INT
			AS 
					SELECT Compras.numeroDocumento, Proveedores.codigoProveedor, Compras.total, Compras.fecha, Compras.descripcion, Proveedores.razonSocial
						FROM Compras INNER JOIN Proveedores
							ON Compras.codigoProveedor = Proveedores.codigoProveedor
go
/*					Actualizar Compra				*/

			CREATE PROCEDURE sp_ActualizarCompra @numeroDocumento INT, @descripcion VARCHAR(60)
			AS 
					UPDATE Compras SET descripcion = @descripcion WHERE numeroDocumento = @numeroDocumento
go
/*					Buscar Compra					*/

			CREATE PROCEDURE sp_BuscarCompra @numeroDocumento INT 
			AS 
					SELECT Compras.numeroDocumento, Proveedores.codigoProveedor, Compras.total, Compras.fecha, Compras.descripcion, Proveedores.paginaWeb,
							Proveedores.contactoPrincipal, Proveedores.razonSocial, Proveedores.nit, Proveedores.direccion
							FROM Compras INNER JOIN Proveedores
								ON Compras.codigoProveedor = Proveedores.codigoProveedor
									WHERE numeroDocumento = @numeroDocumento
							
go
/*					Eliminar Compra					*/
			CREATE PROCEDURE sp_EliminarCompra @numeroDocumento INT 
			AS 
					DELETE FROM Compras WHERE numeroDocumento = @numeroDocumento
go
CREATE TABLE DetalleCompra
(
	codigoProducto			INT NOT NULL,
	codigoProveedor			INT NOT NULL,
	cantidad				INT NOT NULL, 
	codigoDetalleCompra		INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	numeroDocumento			INT NOT NULL, 
	subtotal				DECIMAL(10,2) DEFAULT (0.00) NOT NULL, 
	costoUnitario			DECIMAL (10,2) NOT NULL

		CONSTRAINT FK_DetalleCompra_Productos FOREIGN KEY (codigoProducto)
			REFERENCES Productos(codigoProducto),
			
		CONSTRAINT FK_DetalleCompra_Compras FOREIGN KEY (numeroDocumento)
			REFERENCES Compras(numeroDocumento), 
			
		CONSTRAINT FK_DetalleCompra_Proveedores FOREIGN KEY(codigoProveedor)
			REFERENCES Proveedores(codigoProveedor) 
) 
go
CREATE TRIGGER tr_DetalleCompra_Insertar
ON DetalleCompra
FOR INSERT 
AS	
	BEGIN
			IF((SELECT cantidad FROM inserted)>0)
				BEGIN 
					UPDATE Compras SET total = (DetalleCompra.costoUnitario * DetalleCompra.cantidad) FROM DetalleCompra 
						 WHERE DetalleCompra.numeroDocumento = Compras.numeroDocumento
					UPDATE DetalleCompra SET subtotal = DetalleCompra.costoUnitario*DetalleCompra.cantidad FROM Compras 
						 WHERE DetalleCompra.numeroDocumento = Compras.numeroDocumento
					UPDATE Productos SET precioUnitario = costoUnitario FROM DetalleCompra 
						WHERE DetalleCompra.codigoProducto = Productos.codigoProducto
					UPDATE Productos SET precioDocena = (subtotal / 12) FROM DetalleCompra
						WHERE DetalleCompra.codigoProducto = Productos.codigoProducto
					UPDATE Productos SET existencia = cantidad FROM DetalleCompra   
						WHERE DetalleCompra.codigoProducto = Productos.codigoProducto 
					UPDATE Productos SET precioMayor = costoUnitario * 0.75 FROM DetalleCompra
						WHERE DetalleCompra.codigoProducto = Productos.codigoProducto
				END
	END
go
/*					Agregar Detalle Compra			*/
			CREATE PROCEDURE sp_AgregarDetalleCompra @codigoProducto INT, @codigoProveedor INT, @cantidad INT, @numeroDocumento INT,
														@costoUnitario DECIMAL(10,2)
			AS 
					INSERT INTO DetalleCompra(codigoProducto, codigoProveedor, cantidad, numeroDocumento, costoUnitario)
						VALUES(@codigoProducto, @codigoProveedor, @cantidad, @numeroDocumento, @costoUnitario) 
go
/*					Listar Detalle Compras			*/
			CREATE PROCEDURE sp_ListarDetalleCompras 
			AS 
					SELECT DetalleCompra.codigoProveedor, DetalleCompra.codigoProducto, DetalleCompra.cantidad,
							DetalleCompra.codigoDetalleCompra, DetalleCompra.numeroDocumento, DetalleCompra.subtotal, DetalleCompra.costoUnitario
							FROM DetalleCompra 
go

			CREATE PROCEDURE sp_ListarDetalleCompra @numeroDocumento INT
			as
					SELECT DetalleCompra.codigoDetalleCompra, DetalleCompra.codigoProducto, Productos.descripcion, DetalleCompra.cantidad,
							DetalleCompra.costoUnitario FROM DetalleCompra INNER JOIN Productos ON
								DetalleCompra.codigoProducto = Productos.codigoProducto
									WHERE DetalleCompra.numeroDocumento = @numeroDocumento 
go
/*					Actualizar Detalle Compras		*/
			CREATE PROCEDURE sp_ActualizarDetalleCompra @codigoDetalleCompra INT, @cantidad VARCHAR(50)
			AS
					UPDATE DetalleCompra SET cantidad = @cantidad WHERE codigoDetalleCompra = @codigoDetalleCompra 
go
/*					Buscar Detalle Compra			*/
			CREATE PROCEDURE sp_BuscarDetalleCompra @codigoDetalleCompra INT 
			AS 
					SELECT DetalleCompra.codigoProveedor, DetalleCompra.codigoProducto, DetalleCompra.cantidad,
							DetalleCompra.codigoDetalleCompra, DetalleCompra.numeroDocumento, DetalleCompra.subtotal, DetalleCompra.costoUnitario
							FROM DetalleCompra WHERE codigoDetalleCompra = @codigoDetalleCompra 
go
/*					Eliminar Detalle Compra			*/
			CREATE PROCEDURE sp_EliminarDetalleCompra @codigoDetalleCompra int 
			AS 
				DELETE FROM DetalleCompra WHERE codigoDetalleCompra = @codigoDetalleCompra 
go
CREATE TABLE TelefonoProveedor
(
	codigoProveedor			INT NOT NULL, 
	codigoTelefonoProveedor INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
	numero					VARCHAR(100) NOT NULL,
	descripcion				VARCHAR(60) NOT NULL, 
	
		CONSTRAINT FK_TelefonoProveedor_Proveedores FOREIGN KEY (codigoProveedor)
			REFERENCES Proveedores(codigoProveedor)
)
go
/*					Agregar Telefono Proveedor			*/

			CREATE PROCEDURE sp_AgregarTelefonoProveedor @codigoProveedor INT, @numero VARCHAR(60), @descripcion VARCHAR(60) 
			AS 
						INSERT INTO TelefonoProveedor(codigoProveedor, numero, descripcion)
							VALUES(@codigoProveedor, @numero, @descripcion) 
go
/*					Listar Telefono Proveedor			*/

			CREATE PROCEDURE sp_ListarTelefonoProveedor
			AS 
					SELECT TelefonoProveedor.codigoProveedor, TelefonoProveedor.codigoTelefonoProveedor, 
							TelefonoProveedor.numero, TelefonoProveedor.descripcion FROM TelefonoProveedor 
go
/*					Actualizar Telefono Proveedor		*/

			CREATE PROCEDURE sp_ActualizarTelefonoProveedor @codigoTelefonoProveedor INT, @descripcion VARCHAR(60)
			AS 
						UPDATE TelefonoProveedor SET descripcion = @descripcion 
								WHERE codigoTelefonoProveedor = @codigoTelefonoProveedor 
go
/*					Buscar Telefono Proveedor			*/

			CREATE PROCEDURE sp_BuscarTelefonoProveedor @codigoTelefonoProveedor INT
			AS 
						SELECT TelefonoProveedor.codigoProveedor, TelefonoProveedor.codigoTelefonoProveedor, 
							TelefonoProveedor.numero, TelefonoProveedor.descripcion FROM TelefonoProveedor
							 WHERE codigoTelefonoProveedor = @codigoTelefonoProveedor 

go 
/*					Eliminar Telefono Proveedor			*/

			CREATE PROCEDURE sp_EliminarTelefonoProveedor @codigoTelefonoProveedor INT
			AS 
					DELETE FROM TelefonoProveedor WHERE codigoTelefonoProveedor = @codigoTelefonoProveedor 
go
CREATE TABLE EmailProveedor
(
	codigoEmailProveedor	INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
	codigoProveedor			INT NOT NULL, 
	descripcion				VARCHAR(60) NOT NULL,
	email					VARCHAR(60) NOT NULL,

		CONSTRAINT FK_EmailProveedor_Proveedores FOREIGN KEY(codigoProveedor)
			REFERENCES Proveedores(codigoProveedor) 
)
go

/*					Agregar Email Proveedor				*/
		CREATE PROCEDURE sp_AgregarEmailProveedor @codigoProveedor INT, @descripcion VARCHAR(60), @email VARCHAR(60)
													
		AS 
				INSERT INTO EmailProveedor(codigoProveedor, descripcion, email) 
					VALUES(@codigoProveedor, @descripcion, @email) 
go

/*					Listar Email Proveedor				*/
		CREATE PROCEDURE sp_ListarEmailProveedor 
		AS 
				SELECT EmailProveedor.codigoEmailProveedor, EmailProveedor.codigoProveedor, Proveedores.contactoPrincipal, EmailProveedor.descripcion,
						EmailProveedor.email FROM EmailProveedor INNER JOIN Proveedores
							ON Proveedores.codigoProveedor = EmailProveedor.codigoProveedor  
go

/*					Actualizar Email Proveedor			*/

		CREATE PROCEDURE sp_ActualizarEmailProveedor @descripcion VARCHAR(50), @codigoEmailProveedor INT
		AS 
			
				UPDATE EmailProveedor SET descripcion = @descripcion WHERE codigoEmailProveedor = @codigoEmailProveedor
go 
/*					Buscar Email Proveedor				*/

		CREATE PROCEDURE sp_BuscarEmailProveedor @codigoEmailProveedor INT
		AS 
				SELECT EmailProveedor.codigoEmailProveedor, EmailProveedor.codigoProveedor, Proveedores.contactoPrincipal, EmailProveedor.descripcion,
					EmailProveedor.email FROM EmailProveedor INNER JOIN Proveedores
						ON Proveedores.codigoProveedor = EmailProveedor.codigoProveedor
							WHERE Proveedores.codigoProveedor = EmailProveedor.codigoProveedor 
go

/*					Eliminar Email Proveedor			*/

		CREATE PROCEDURE sp_EliminarEmailProveedor @codigoEmailProveedor INT
		AS 
				DELETE FROM EmailProveedor WHERE codigoEmailProveedor = @codigoEmailProveedor
go
CREATE TABLE Clientes
(
	codigoCliente			INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	direccion				VARCHAR(100) NOT NULL, 
	nit						VARCHAR(60) NOT NULL,
	nombre					VARCHAR(100) NOT NULL
)
go
/*				Agregar Clientes			*/
		CREATE PROCEDURE sp_AgregarClientes @direccion VARCHAR(60), @nit VARCHAR(50), @nombre VARCHAR(60)
		AS 
				INSERT INTO Clientes(direccion, nit, nombre)
					VALUES(@direccion, @nit, @nombre)
go
/*				Listar Clientes				*/
		CREATE PROCEDURE sp_ListarClientes 
		AS 
				SELECT Clientes.codigoCliente, Clientes.direccion, Clientes.nit, Clientes.nombre
					FROM Clientes 
go
/*				Actualizar Cliente			*/
		CREATE PROCEDURE sp_ActualizarCliente @nombre VARCHAR(50), @codigoCliente INT
		AS 
				UPDATE Clientes SET nombre = @nombre WHERE codigoCliente = @codigoCliente 
go
/*				Buscar Cliente			*/
		CREATE PROCEDURE sp_BuscarCliente @codigoCliente INT
		AS 
				SELECT Clientes.codigoCliente, Clientes.direccion, Clientes.nit, Clientes.nombre
					FROM Clientes WHERE codigoCliente = @codigoCliente 
go
/*				Eliminar Cliente		*/
		CREATE PROCEDURE sp_EliminarCliente @codigoCliente INT
		AS 
			DELETE FROM Clientes WHERE codigoCliente = @codigoCliente 
go
CREATE TABLE EmailCliente
(
	codigoEmailCliente		INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	descripcion				VARCHAR(100) NOT NULL, 
	email					VARCHAR(100) NOT NULL,
	codigoCliente			INT NOT NULL, 

	CONSTRAINT FK_EmailCliente_Clientes FOREIGN KEY(codigoCliente)
			REFERENCES Clientes(codigoCliente) 
)
go
/*				Agregar Email Cliente			*/
		CREATE PROCEDURE sp_AgregarEmailCliente @codigoCliente INT, @descripcion VARCHAR(50), @email VARCHAR(50) 
		AS 
				INSERT INTO EmailCliente(descripcion, email, codigoCliente)
						VALUES(@descripcion, @email, @codigoCliente) 
go		
/*				Listar Email Cliente			*/
		CREATE PROCEDURE sp_ListarEmailCliente 
		AS 
			SELECT EmailCliente.codigoEmailCliente, EmailCliente.descripcion, EmailCliente.email, EmailCliente.codigoCliente
					FROM EmailCliente
go
 
/*				Actualizar Email Cliente		*/
		CREATE PROCEDURE sp_ActualizarEmailCliente @codigoEmailCliente INT, @descripcion VARCHAR(50) 
		AS 
				UPDATE EmailCliente SET descripcion = @descripcion WHERE codigoEmailCliente = @codigoEmailCliente 
go
/*				Buscar Email Cliente			*/
		CREATE PROCEDURE sp_BuscarEmailCliente @codigoEmailCliente INT
		AS 
					SELECT EmailCliente.codigoCliente, EmailCliente.codigoEmailCliente, EmailCliente.descripcion, EmailCliente.email
					FROM EmailCliente WHERE codigoCliente = @codigoEmailCliente
go
/*				Eliminar Email Cliente			*/
		CREATE PROCEDURE sp_EliminarEmailCliente @codigoEmailCliente INT
		AS 
			DELETE FROM EmailCliente WHERE codigoEmailCliente = @codigoEmailCliente 
go
CREATE TABLE TelefonoCliente
(
	codigoTelefonoCliente	INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	numero					VARCHAR (100) NOT NULL,
	descripcion				VARCHAR(100) NOT NULL,
	codigoCliente			INT NOT NULL,

	CONSTRAINT FK_TelefonoCliente_Clientes FOREIGN KEY(codigoCliente)
			REFERENCES Clientes(codigoCliente) 
)
go
/*				Agregar Telefono Cliente		*/
		CREATE PROCEDURE sp_AgregarTelefonoCliente @codigoCliente INT, @numero VARCHAR(100), @descripcion VARCHAR(50)
		AS 
				INSERT INTO TelefonoCliente (numero, descripcion, codigoCliente)
					VALUES(@numero, @descripcion, @codigoCliente) 
go
/*				Listar Telefono Cliente			*/
		CREATE PROCEDURE sp_ListarTelefonoCliente 
		AS 
				SELECT TelefonoCliente.codigoTelefonoCliente,  TelefonoCliente.numero, TelefonoCliente.descripcion, TelefonoCliente.codigoCliente
					FROM TelefonoCliente 
					
go
/*				Actualizar Telefono Cliente		*/
		CREATE PROCEDURE sp_ActualizarTelefonoCliente  @codigoTelefonoCliente INT, @numero VARCHAR(50), @descripcion VARCHAR(100)
		AS 
				UPDATE TelefonoCliente SET numero = @numero, descripcion = @descripcion WHERE codigoTelefonoCliente = @codigoTelefonoCliente 
go
/*				Buscar Telefono Cliente			*/
		CREATE PROCEDURE sp_BuscarTelefonoCliente @codigoTelefonoCliente INT
		AS 
			
				SELECT TelefonoCliente.codigoTelefonoCliente,  TelefonoCliente.numero, TelefonoCliente.descripcion, TelefonoCliente.codigoCliente
					FROM TelefonoCliente WHERE codigoTelefonoCliente = @codigoTelefonoCliente 
go
/*				Eliminar Telefono Cliente			*/
		CREATE PROCEDURE sp_EliminarTelefonoCliente @codigoTelefonoCliente INT
		AS 
			DELETE FROM TelefonoCliente WHERE codigoTelefonoCliente = @codigoTelefonoCliente 
go
CREATE TABLE Facturas
(
	numeroFactura			INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	estado					VARCHAR(100) NOT NULL,
	fecha					DATETIME NOT NULL,
	nit						VARCHAR(100) NOT NULL,
	total					DECIMAL(10,2) DEFAULT (0.00) NOT NULL,
	codigoCliente			INT NOT NULL,

	CONSTRAINT FK_Facturas_Clientes FOREIGN KEY(codigoCliente)
			REFERENCES Clientes(codigoCliente)
) 
go	
/*				Agregar Facturas				*/
		CREATE PROCEDURE sp_AgregarFactura @codigoCliente INT, @estado VARCHAR(50), @fecha DATETIME, @nit VARCHAR(50) 
		AS 
				INSERT INTO Facturas(codigoCliente, estado, fecha, nit) 
					VALUES(@codigoCliente, @estado, @fecha, @nit) 

go 
/*				Listar Facturas					*/
		CREATE PROCEDURE sp_ListarFacturas 
		AS 
			SELECT Facturas.numeroFactura, Facturas.estado, Facturas.fecha, Facturas.nit, Facturas.total, Facturas.codigoCliente
				FROM Facturas 
go
	 
/*				Actualizar Factura				*/

		CREATE PROCEDURE sp_ActualizarFactura @numeroFactura INT, @estado VARCHAR(50)
		AS 
				UPDATE Facturas SET estado = @estado WHERE numeroFactura = @numeroFactura 
go
/*				Buscar Factura					*/
		CREATE PROCEDURE sp_BuscarFactura @numeroFactura INT
		AS 
			 SELECT Facturas.numeroFactura, Facturas.estado, Facturas.fecha, Facturas.nit, Facturas.total, Facturas.codigoCliente
				FROM Facturas WHERE numeroFactura = @numeroFactura
go
/*				Eliminar Factura				*/
		CREATE PROCEDURE sp_EliminarFactura @numeroFactura INT 
		AS 
				DELETE FROM Facturas WHERE numeroFactura = @numeroFactura 
go
CREATE TABLE DetalleFactura
(
	codigoDetalleFactura	INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	cantidad				INT NOT NULL,
	numeroFactura			INT NOT NULL,
	precio					DECIMAL (10,2) NOT NULL DEFAULT(0.00),
	codigoProducto			INT NOT NULL,

	CONSTRAINT FK_DetalleFactura_Facturas FOREIGN KEY(numeroFactura)
			REFERENCES Facturas(numeroFactura),
	CONSTRAINT FK_DetalleFactura_Productos FOREIGN KEY(codigoProducto)
			REFERENCES Productos(codigoProducto)
)
go
CREATE TRIGGER tr_DetalleFactura_Insertar
ON DetalleFactura 
FOR INSERT
AS
				DECLARE @existencia INT

				SELECT @existencia = existencia FROM Productos 
					JOIN inserted ON inserted.codigoProducto = Productos.codigoProducto
						WHERE inserted.codigoProducto = Productos.codigoProducto 

				if((SELECT cantidad FROM inserted)<@existencia)
					BEGIN 
						UPDATE Productos SET existencia = existencia - inserted.cantidad FROM Productos 
							JOIN inserted ON inserted.codigoProducto = Productos.codigoProducto	
								 WHERE inserted.codigoProducto = Productos.codigoProducto
						UPDATE Facturas SET total = cantidad * precio FROM Facturas 
							JOIN inserted ON inserted.numeroFactura = Facturas.numeroFactura
								WHERE inserted.numeroFactura = Facturas.numeroFactura 		
					END
					ELSE 
						BEGIN 
							RAISERROR('No se pueden vender esta cantidad de productos',16,1)
							ROLLBACK TRANSACTION 
						END
go 
/*				Agregar Detalle Factura			*/

		CREATE PROCEDURE sp_AgregarDetalleFactura @numeroFactura INT, @codigoProducto INT, @cantidad INT, @precio DECIMAL(10,2)
		AS 
				INSERT INTO DetalleFactura(numeroFactura, codigoProducto, cantidad, precio)
						VALUES(@numeroFactura, @codigoProducto, @cantidad, @precio) 
go 

/*				Listar Detalle Factura			*/

		CREATE PROCEDURE sp_ListarDetalleFactura
		AS 
				SELECT DetalleFactura.codigoDetalleFactura, DetalleFactura.cantidad, DetalleFactura.numeroFactura, DetalleFactura.precio,
						DetalleFactura.codigoProducto
						FROM DetalleFactura 
go
/*				Actualizar Detalle Factura			*/
		CREATE PROCEDURE sp_ActualizarDetalleFactura @cantidad INT, @codigoDetalleFactura INT
		AS 
				UPDATE DetalleFactura SET cantidad = @cantidad WHERE codigoDetalleFactura = @codigoDetalleFactura
go

/*				Buscar Detalle Factura				*/

		CREATE PROCEDURE sp_BuscarDetalleFactura @codigoDetalleFactura INT 
		AS 
				SELECT DetalleFactura.cantidad, DetalleFactura.numeroFactura, DetalleFactura.precio, DetalleFactura.codigoProducto
						FROM DetalleFactura WHERE codigoDetalleFactura = @codigoDetalleFactura
go
/*				Eliminar Detalle Factura			*/

		CREATE PROCEDURE sp_EliminarDetalleFactura @codigoDetalleFactura INT
		AS 
				DELETE FROM DetalleFactura WHERE codigoDetalleFactura = @codigoDetalleFactura 
go
CREATE TABLE Usuarios
(
	codigoUsuario		INT PRIMARY KEY IDENTITY(1,1),
	nombreUsuario		VARCHAR(100) NOT NULL,
	email				VARCHAR(100) NOT NULL,
	usuario				VARCHAR(100) NOT NULL,
	contrasena			VARCHAR(100) NOT NULL,
	tipoUsuario			VARCHAR(100) NOT NULL
)
go
/*				Agregar Usuarios				*/
		CREATE PROCEDURE sp_AgregarUsuario @nombreUsuario VARCHAR(100), @email VARCHAR(100), 
											 @usuario VARCHAR(100), @contrasena VARCHAR(100),
												@tipoUsuario VARCHAR(100)
		AS
				INSERT INTO Usuarios(nombreUsuario, email, usuario, contrasena, tipoUsuario)
						VALUES(@nombreUsuario, @email, @usuario, @contrasena, @tipoUsuario)
go
/*				Listar Usuarios					*/
		CREATE PROCEDURE sp_ListarUsuarios 
		AS
				SELECT Usuarios.codigoUsuario, Usuarios.nombreUsuario, Usuarios.email, Usuarios.usuario, Usuarios.contrasena,
							Usuarios.tipoUsuario FROM Usuarios 
go
/*				Buscar Usuarios					*/
		CREATE PROCEDURE sp_BuscarUsuarios @codigoUsuario INT
		AS			
				SELECT Usuarios.codigoUsuario, Usuarios.nombreUsuario, Usuarios.email, Usuarios.usuario, Usuarios.contrasena,
							Usuarios.tipoUsuario FROM Usuarios WHERE codigoUsuario= @codigoUsuario
go

		CREATE PROCEDURE sp_BuscarUsuario @usuario VARCHAR(100), @contrasena VARCHAR(100)
		AS
				 SELECT Usuarios.codigoUsuario, Usuarios.nombreUsuario, Usuarios.email, Usuarios.usuario, Usuarios.contrasena,
							Usuarios.tipoUsuario FROM Usuarios WHERE usuario = @usuario AND contrasena = @contrasena 
							
go
		CREATE PROCEDURE sp_ActualizarUsuario @codigoUsuario INT, @usuario VARCHAR(100)
		AS 
				UPDATE Usuarios SET usuario = @usuario WHERE codigoUsuario = @codigoUsuario

				
go
		CREATE PROCEDURE sp_EliminarUsuario @codigoUsuario INT
		AS
				DELETE FROM Usuarios WHERE codigoUsuario = @codigoUsuario 
