/***********************-----------INICIO----------------*************************/
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'BEBINOS')
BEGIN
    DROP DATABASE BEBINOS;
END
GO

Create database BEBINOS
GO

use BEBINOS

set dateformat ymd
go

/***********************-----------TABLAS----------------*************************/
/*---------------TABLA CLIENTES----------------------*/
	CREATE TABLE tb_Cliente (
		ClienteID INT PRIMARY KEY IDENTITY(1,1),
		Nombre NVARCHAR(100) NOT NULL,
		Apellido NVARCHAR(100) NOT NULL,
		DNI NVARCHAR(20) NOT NULL,
		Email NVARCHAR(100),
		Telefono NVARCHAR(20),
		Direccion NVARCHAR(255),
		FechaRegistro DATETIME NOT NULL,
		IsActive BIT NOT NULL DEFAULT 1
	)
	GO

/*---------------TABLA CARGOS----------------------*/
	CREATE TABLE tb_Cargo (
		CargoID INT PRIMARY KEY IDENTITY(1,1),
		NomCargo NVARCHAR(100) NOT NULL,
		Descripcion NVARCHAR(250)
	)
	GO

/*---------------TABLA EMPLEADOS----------------------*/
	CREATE TABLE tb_Empleados (
		EmpleadoID INT PRIMARY KEY IDENTITY(1,1),
		Nombre NVARCHAR(50) NOT NULL,
		Apellido NVARCHAR(50) NOT NULL,
		Email NVARCHAR(100) NOT NULL UNIQUE,
		Telefono NVARCHAR(15),
		Direccion NVARCHAR(255),
		FechaContratacion DATETIME,
		CargoID INT NOT NULL,
		IsActive BIT NOT NULL DEFAULT 1,
		FOREIGN KEY (CargoID) REFERENCES tb_Cargo(CargoID)
	)
	GO

/*--------------------------CATEGORIA------------------------------*/
	CREATE TABLE tb_Categoria (
		CategoriaID INT PRIMARY KEY IDENTITY(1,1),
		Nombre NVARCHAR(100) NOT NULL
	)
	GO

/*--------------------------PRODUCTOS------------------------------*/
	CREATE TABLE tb_Producto (
		ProductoID INT PRIMARY KEY IDENTITY(1,1),
		Nombre NVARCHAR(100) NOT NULL,
		Descripcion NVARCHAR(255),
		Precio DECIMAL(10, 2) NOT NULL,
		Stock INT NOT NULL,
		CategoriaID INT,
		FechaAgregado DATETIME,
		IsActive BIT NOT NULL DEFAULT 1,
		FOREIGN KEY (CategoriaID) REFERENCES tb_Categoria(CategoriaID)
	)
	GO

/*--------------------------TABLA FORMA DE PAGO------------------------------*/
	CREATE TABLE FormaPago (
		FormaPagoID INT PRIMARY KEY IDENTITY,
		Descripcion NVARCHAR(100) NOT NULL
	)
	GO

/*--------------------------TABLA NUMERO DE SERIE------------------------------*/
	CREATE TABLE NumerosSerie (
		TipoComprobante NVARCHAR(10) PRIMARY KEY,
		UltimoNumero INT NOT NULL
	)
	GO

/*--------------------------TABLA VENTA------------------------------*/
	CREATE TABLE tb_Ventas (
		VentaID INT PRIMARY KEY IDENTITY(1,1),
		FechaVenta DATETIME NOT NULL,
		MontoTotal DECIMAL(18, 2) NOT NULL,
		FormaPagoID INT,
		NumeroSerie NVARCHAR(10),
		DNI NVARCHAR(20),
		NombreCompleto NVARCHAR(200),
		FOREIGN KEY (FormaPagoID) REFERENCES FormaPago(FormaPagoID)
	)
	GO


/*--------------------------TABLA DETALLE DE VENTA------------------------------*/
	CREATE TABLE DetalleVentas (
		DetalleVentaID INT PRIMARY KEY IDENTITY(1,1),
		VentaID INT NOT NULL,
		ProductoID INT NOT NULL,
		ClienteID INT NOT NULL, 
		Cantidad INT NOT NULL,
		PrecioUnitario DECIMAL(18, 2) NOT NULL,
		SubTotal DECIMAL(18, 2) NOT NULL,
		FOREIGN KEY (VentaID) REFERENCES tb_Ventas (VentaID),
		FOREIGN KEY (ProductoID) REFERENCES tb_Producto(ProductoID),
		FOREIGN KEY (ClienteID) REFERENCES tb_Cliente(ClienteID)
	)
	GO

/*--------------------------TABLA ROLES------------------------------*/
CREATE TABLE Roles (
    RoleId INT PRIMARY KEY IDENTITY,
    RoleName NVARCHAR(50) NOT NULL
)
GO

/*--------------------------TABLA USUARIOS------------------------------*/
CREATE TABLE Users (
    UserId INT PRIMARY KEY IDENTITY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Contrasena NVARCHAR(256) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    RoleId INT FOREIGN KEY REFERENCES Roles(RoleId)
)
GO

/***********************-----------INSERCIONES----------------*************************/
/*--------------------------INSERCIONES DE CLIENTES------------------------------*/
INSERT INTO tb_Cliente (Nombre, Apellido, DNI, Email, Telefono, Direccion, FechaRegistro, IsActive) VALUES 
('Ana', 'García', '12345678', 'ana.garcia@example.com', '912345678', 'Avenida Siempre Viva 742', '2022-01-15', 1),
('Luis', 'Martínez', '87654321', 'luis.martinez@example.com', '923456789', 'Calle de las Flores 3', '2023-02-10', 1),
('Carlos', 'López', '23456789', 'carlos.lopez@example.com', '934567890', 'Calle Luna 23', '2021-07-30', 1),
('María', 'Fernández', '34567890', 'maria.fernandez@example.com', '945678901', 'Paseo del Prado 15', '2020-12-05', 1),
('Jorge', 'Sánchez', '45678901', 'jorge.sanchez@example.com', '956789012', 'Calle Sol 45', '2023-04-20', 1),
('Lucía', 'Ramírez', '56789012', 'lucia.ramirez@example.com', '967890123', 'Avenida Libertad 56', '2022-08-12', 1),
('Miguel', 'Torres', '67890123', 'miguel.torres@example.com', '978901234', 'Calle Arco 7', '2021-09-25', 0),
('Sofía', 'González', '78901234', 'sofia.gonzalez@example.com', '989012345', 'Calle Jardín 9', '2020-11-14', 1),
('Raúl', 'Hernández', '89012345', 'raul.hernandez@example.com', '990123456', 'Calle Estrella 18', '2023-03-07', 1),
('Valeria', 'Díaz', '90123456', 'valeria.diaz@example.com', '991234567', 'Calle Ríos 12', '2022-06-22', 0);
GO

/*--------------------------INSERCIONES DE CARGO------------------------------*/
INSERT INTO tb_Cargo (NomCargo, Descripcion) VALUES 
('Gerente', 'Gerente de tienda con responsabilidades de supervisión'),
('Asistente', 'Asistente de ventas con atención al cliente'),
('Cajero', 'Responsable de manejar la caja registradora'),
('Almacenista', 'Encargado del almacenamiento y organización de productos'),
('Supervisor', 'Supervisor de equipo de ventas'),
('Recepcionista', 'Responsable de la recepción y atención al cliente'),
('Contador', 'Encargado de la contabilidad y finanzas'),
('Vendedor', 'Vendedor con enfoque en atención al cliente'),
('Marketing', 'Encargado de las campañas de marketing y publicidad'),
('Seguridad', 'Responsable de la seguridad en la tienda')
GO

/*--------------------------INSERCIONES DE EMPLEADOS------------------------------*/
INSERT INTO tb_Empleados (Nombre, Apellido, Email, Telefono, Direccion, FechaContratacion,CargoID) VALUES 
('Laura', 'Gómez', 'laura.gomez@example.com', '123123123', 'Calle 456', '2010-02-10', 1),
('Pedro', 'Martínez', 'pedro.martinez@example.com', '321321321', 'Avenida 789', '2012-05-20', 2),
('Elena', 'Santos', 'elena.santos@example.com', '432432432', 'Calle 101', '2010-02-09', 3),
('Roberto', 'Fernández', 'roberto.fernandez@example.com', '543543543', 'Avenida 102', '2010-02-08', 4),
('Marta', 'Ruiz', 'marta.ruiz@example.com', '654654654', 'Calle 103', '2013-03-02', 5),
('Sergio', 'Ramos', 'sergio.ramos@example.com', '765765765', 'Avenida 104', '2015-06-07', 6),
('Claudia', 'Jiménez', 'claudia.jimenez@example.com', '876876876', 'Calle 105', '2016-08-13', 7),
('Luis', 'Morales', 'luis.morales@example.com', '987987987', 'Avenida 106', '2020-04-05', 8),
('Patricia', 'Ortiz', 'patricia.ortiz@example.com', '098098098', 'Calle 107', '2018-07-15', 9),
('Jorge', 'Iglesias', 'jorge.iglesias@example.com', '109109109', 'Avenida 108','2019-11-12', 10)
GO

/*--------------------------INSERCIONES DE CATEGORIAS------------------------------*/
INSERT INTO tb_Categoria VALUES 
('Lacteos'),
('Abarrotes'),
('Licores'),
('Snacks'),
('Bebidas'),
('Alimentos para mascotas'),
('Articulos de aseo'),
('Cuidado personal'),
('Cereales'),
('Congelados');
GO

/*--------------------------INSERCIONES DE PRODUCTOS------------------------------*/
INSERT INTO tb_Producto (Nombre, Descripcion, Precio, Stock, CategoriaID, FechaAgregado, IsActive) VALUES 
('Leche Entera', 'Leche entera pasteurizada', 1.20, 50, 1, '2023-01-15', 1),
('Arroz Integral', 'Paquete de 1kg de arroz integral', 0.80, 100, 2, '2023-02-10', 1),
('Vino Tinto', 'Botella de vino tinto de 750ml', 12.50, 30, 3, '2023-03-05', 1),
('Chips de Papas', 'Bolsa de chips de papas', 1.50, 75, 4, '2023-04-01', 1),
('Agua Mineral', 'Botella de agua mineral 500ml', 0.90, 200, 5, '2023-05-20', 1),
('Alimento para Perros', 'Saco de 5kg de alimento para perros', 20.00, 25, 6, '2023-06-15', 1),
('Detergente Líquido', 'Detergente líquido para ropa', 5.00, 40, 7, '2023-07-10', 1),
('Shampoo Anticaspa', 'Shampoo anticaspa 400ml', 3.50, 60, 8, '2023-08-05', 1),
('Cereal Integral', 'Caja de cereal integral 500g', 2.00, 80, 9, '2023-09-01', 1),
('Pizza Congelada', 'Pizza congelada de pepperoni', 4.50, 20, 10, '2023-10-10', 1);
GO

/*--------------------------INSERCIONES DE FORMA DE PAGO------------------------------*/
INSERT INTO FormaPago VALUES 
('Efectivo'),
('Tarjeta debito'),
('Tarjeta Credito'),
('QR')
GO

/*--------------------------INSERCIONES DE NUMERO DE SERIE------------------------------*/
INSERT INTO NumerosSerie (TipoComprobante, UltimoNumero) VALUES 
('Boleta', 0),
('Factura', 0);
GO

/*--------------------------INSERCIONES DE VENTA------------------------------*/
INSERT INTO tb_Ventas (FechaVenta, MontoTotal, FormaPagoID, NumeroSerie, DNI, NombreCompleto) VALUES 
('2024-01-10', 120.50, 1, 'B001', '12345678', 'Juan Pérez'),
('2024-01-15', 250.00, 2, 'F001', '23456789', 'Ana García'),
('2024-02-05', 75.99, 1, 'B002', '34567890', 'Carlos López'),
('2024-02-20', 300.75, 3, 'F002', '45678901', 'María Fernández'),
('2024-03-10', 450.00, 2, 'B003', '56789012', 'Jorge Sánchez'),
('2024-03-15', 99.99, 1, 'B004', '67890123', 'Lucía Ramírez'),
('2024-04-05', 200.00, 3, 'F003', '78901234', 'Miguel Torres'),
('2024-04-20', 180.50, 2, 'B005', '89012345', 'Sofía González'),
('2024-05-01', 350.00, 4, 'F004', '90123456', 'Raúl Hernández'),
('2024-05-15', 500.00, 3, 'B006', '01234567', 'Valeria Díaz');
GO

/*--------------------------INSERCIONES DE DETALLE DE VENTAS------------------------------*/
INSERT INTO DetalleVentas (VentaID, ProductoID, ClienteID, Cantidad, PrecioUnitario, SubTotal) VALUES 
(1, 1, 1, 2, 1.20, 2.40),  
(1, 2, 1, 1, 0.80, 0.80), 
(2, 3, 2, 3, 12.50, 37.50),
(2, 4, 2, 5, 1.50, 7.50),  
(3, 5, 3, 6, 0.90, 5.40),  
(4, 6, 4, 1, 20.00, 20.00), 
(5, 7, 5, 2, 5.00, 10.00), 
(6, 8, 6, 3, 3.50, 10.50),   
(7, 9, 7, 4, 2.00, 8.00),    
(8, 10, 8, 2, 4.50, 9.00)
GO

/*--------------------------INSERTAR DE ROLES------------------------------*/
INSERT INTO Roles (RoleName) VALUES ('Administrador'), ('Usuario')
GO

/*******************************PROCEDIMIENTOS ALMACENADOS**********************************************/
/***********************-----------PROCEDURES CLIENTES----------------*************************/
/*--------------------------PROCEDURE LISTAR CLIENTES------------------------------*/
CREATE OR ALTER PROCEDURE usp_get_Clientes
AS
BEGIN
	SELECT 
		ClienteID,
		Nombre,
		Apellido,
		DNI,
		Email,
		Telefono,
		Direccion,
		FechaRegistro
			
	FROM tb_Cliente
	WHERE IsActive = 1;
END
GO

/*--------------------------PROCEDURE INSERTAR CLIENTES------------------------------*/
CREATE OR ALTER PROCEDURE usp_insert_Cliente
	@Nombre NVARCHAR(100),
	@Apellido NVARCHAR(100),
	@DNI NVARCHAR(20),
	@Email NVARCHAR(100),
	@Telefono NVARCHAR(20),
	@Direccion NVARCHAR(255),
	@FechaRegistro DATETIME
AS
BEGIN
	INSERT INTO tb_Cliente (Nombre, Apellido, DNI, Email, Telefono, Direccion, FechaRegistro, IsActive)
	VALUES (@Nombre, @Apellido, @DNI, @Email, @Telefono, @Direccion, @FechaRegistro, 1);
END
GO

/*--------------------------PROCEDURE ACTUALIZAR CLIENTES------------------------------*/
CREATE OR ALTER PROCEDURE usp_update_Cliente
	@ClienteID INT,
	@Nombre NVARCHAR(100),
	@Apellido NVARCHAR(100),
	@DNI NVARCHAR(20),
	@Email NVARCHAR(100),
	@Telefono NVARCHAR(20),
	@Direccion NVARCHAR(255)	
AS
BEGIN
	UPDATE tb_Cliente
	SET Nombre = @Nombre,
		Apellido = @Apellido,
		DNI = @DNI,
		Email = @Email,
		Telefono = @Telefono,
		Direccion = @Direccion
			
	WHERE ClienteID = @ClienteID;
END
GO

/*--------------------------PROCEDURE ELIMINAR CLIENTES------------------------------*/
CREATE OR ALTER PROCEDURE usp_eliminar_logico_Cliente
	@ClienteID INT
AS
BEGIN
	UPDATE tb_Cliente
	SET IsActive = 0
	WHERE ClienteID = @ClienteID;
END
GO

/***********************-----------PROCEDURES EMPLEADO----------------*************************/
/*--------------------------PROCEDURE LISTAR EMPLEADO------------------------------*/
CREATE OR ALTER PROCEDURE usp_get_Empleados
AS
BEGIN
	SELECT 
		e.EmpleadoID,
		e.Nombre,
		e.Apellido,
		e.Email,
		e.Telefono,
		e.Direccion,
		e.FechaContratacion,
		e.CargoID,
		c.NomCargo
	FROM tb_Empleados e
	INNER JOIN tb_Cargo c ON e.CargoID = c.CargoID
	WHERE e.IsActive = 1;
END
GO

/*--------------------------PROCEDURE INSERTAR EMPLEADO------------------------------*/
CREATE OR ALTER PROCEDURE usp_insert_Empleado
	@Nombre NVARCHAR(50),
	@Apellido NVARCHAR(50),
	@Email NVARCHAR(100),
	@Telefono NVARCHAR(15),
	@Direccion NVARCHAR(255),
	@FechaContratacion DATETIME,
	@CargoID INT
AS
BEGIN
	INSERT INTO tb_Empleados (Nombre, Apellido, Email, Telefono, Direccion, FechaContratacion, CargoID, IsActive)
	VALUES (@Nombre, @Apellido, @Email, @Telefono, @Direccion, @FechaContratacion, @CargoID, 1);
END
GO

/*--------------------------PROCEDURE ACTUALIZAR EMPLEADO------------------------------*/
CREATE OR ALTER PROCEDURE usp_update_Empleado
	@EmpleadoID INT,
	@Nombre NVARCHAR(50),
	@Apellido NVARCHAR(50),
	@Email NVARCHAR(100),
	@Telefono NVARCHAR(15),
	@Direccion NVARCHAR(255),
	@FechaContratacion DATETIME,
	@CargoID INT
AS
BEGIN
	UPDATE tb_Empleados
	SET Nombre = @Nombre,
		Apellido = @Apellido,
		Email = @Email,
		Telefono = @Telefono,
		Direccion = @Direccion,
		FechaContratacion = @FechaContratacion,
		CargoID = @CargoID
	WHERE EmpleadoID = @EmpleadoID;
END
GO

/*--------------------------PROCEDURE ELIMINAR EMPLEADO------------------------------*/
CREATE OR ALTER PROCEDURE usp_eliminar_logico_Empleado
	@EmpleadoID INT
AS
BEGIN
	UPDATE tb_Empleados
	SET IsActive = 0
	WHERE EmpleadoID = @EmpleadoID;
END
GO

/***********************-----------PROCEDURES PRODUCTO----------------*************************/
/*--------------------------PROCEDURE LISTAR PRODUCTO------------------------------*/
CREATE OR ALTER PROCEDURE SP_LISTAR_PRODUCTO
AS
BEGIN
	SELECT 
		ProductoID,
		Nombre,
		Descripcion,
		Precio,
		Stock,
		CategoriaID,
		FechaAgregado
	FROM tb_Producto
	WHERE IsActive = 1;
END
GO

/*--------------------------PROCEDURE INSERTAR PRODUCTO------------------------------*/
CREATE OR ALTER PROCEDURE SP_REGISTRAR_PRODUCTO
	@Nombre NVARCHAR(100),
	@Descripcion NVARCHAR(255),
	@Precio DECIMAL(10, 2),
	@Stock INT,
	@CategoriaID INT,
	@FechaAgregado DATETIME
AS
BEGIN
	INSERT INTO tb_Producto (Nombre, Descripcion, Precio, Stock, CategoriaID, FechaAgregado, IsActive)
	VALUES (@Nombre, @Descripcion, @Precio, @Stock, @CategoriaID, @FechaAgregado, 1);
END
GO

/*--------------------------PROCEDURE ACTUALIZAR PRODUCTO------------------------------*/
CREATE OR ALTER PROCEDURE SP_ACTUALIZAR_PRODUCTO
    @ProductoID INT,
    @Nombre NVARCHAR(100),
    @Descripcion NVARCHAR(255),
    @Precio DECIMAL(10,2),
    @Stock INT,
    @CategoriaID INT,
	@FechaAgregado DATETIME
AS
BEGIN
    UPDATE tb_Producto
    SET Nombre = @Nombre,
        Descripcion = @Descripcion,
        Precio = @Precio,
        Stock = @Stock,
        CategoriaID = @CategoriaID,
		FechaAgregado = @FechaAgregado
    WHERE ProductoID = @ProductoID
END
GO

/*--------------------------PROCEDURE ELIMINAR PRODUCTO------------------------------*/
CREATE OR ALTER PROC SP_ELIMINAR_PRODUCTO
	@ProductoID INT
AS
BEGIN
	UPDATE tb_Producto
	SET IsActive = 0
	WHERE ProductoID = @ProductoID;
END
GO

/*--------------------------PROCEDURE BUSCAR PRODUCTO------------------------------*/
CREATE OR ALTER PROCEDURE SP_BUSCAR_PRODUCTO
    @query NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON

    SELECT ProductoID, Nombre, Precio
    FROM tb_Producto
    WHERE Nombre LIKE '%' + @query + '%';
END
GO

/***********************-----------PROCEDURES VENTA----------------*************************/
/*--------------------------PROCEDURE LISTAR VENTA------------------------------*/
CREATE OR ALTER PROC SP_LISTAR_VENTA
AS
BEGIN
	SELECT 
		VentaID,
		V.FechaVenta,
		MontoTotal,
		FP.Descripcion,
		NumeroSerie,
		DNI,
		NombreCompleto
	FROM tb_Ventas V
	INNER JOIN FormaPago FP ON FP.FormaPagoID = V.FormaPagoID
END
GO


/*--------------------------PROCEDURE INSERTAR VENTA------------------------------*/
CREATE OR ALTER PROCEDURE SP_REGISTRAR_VENTA
    @FechaVenta DATETIME,
    @MontoTotal DECIMAL(18, 2),
    @FormaPagoID INT,
    @NumeroSerie NVARCHAR(10),
    @DNI NVARCHAR(20),
    @NombreCompleto NVARCHAR(200),
    @VentaID INT OUTPUT  -- Parámetro de salida para obtener el ID de la venta
AS
BEGIN
    INSERT INTO tb_Ventas (FechaVenta, MontoTotal, FormaPagoID, NumeroSerie, DNI, NombreCompleto)
    VALUES (@FechaVenta, @MontoTotal, @FormaPagoID, @NumeroSerie, @DNI, @NombreCompleto);

    -- Obtener el ID de la venta recién insertada
    SET @VentaID = SCOPE_IDENTITY();
END
GO


/*--------------------------PROCEDURE OBTENER VENTA------------------------------*/
CREATE PROCEDURE SP_OBTENER_VENTA_POR_ID
	@VentaID INT
AS
BEGIN
	SELECT VentaID, FechaVenta, MontoTotal, FormaPagoID, NumeroSerie, DNI, NombreCompleto
	FROM tb_Ventas
	WHERE VentaID = @VentaID;
END
GO

/*--------------------------PROCEDURE REGISTRAR DETALLE DE VENTA------------------------------*/
CREATE OR ALTER PROCEDURE SP_REGISTRAR_DETALLE_VENTA
	@VentaID INT,
	@ProductoID INT,
	@Cantidad INT,
	@PrecioUnitario DECIMAL(18, 2),
	@SubTotal DECIMAL(18, 2)
AS
BEGIN
	INSERT INTO DetalleVentas (VentaID, ProductoID, Cantidad, PrecioUnitario, SubTotal)
	VALUES (@VentaID, @ProductoID, @Cantidad, @PrecioUnitario, @SubTotal);
END
GO

/*--------------------------PROCEDURE REGISTRAR DETALLE DE VENTA------------------------------*/
CREATE OR ALTER PROCEDURE SP_OBTENER_DETALLES_VENTA_POR_ID
   @VentaID INT
AS
BEGIN
	SELECT DetalleVentaID, VentaID, ProductoID, Cantidad, PrecioUnitario, SubTotal
	FROM DetalleVentas
	WHERE VentaID = @VentaID;
END
GO


/********************PROCEDURE REPORTES**********************/
/*--------------------------PROCEDURE MOSTRAR REPORTE------------------------------*/
CREATE OR ALTER PROC SP_REPORTE_DASHBOARD
AS
BEGIN
	select
	(select COUNT(*) from Tb_Cliente) [TotalCliente],
	(select ISNULL(SUM(Cantidad),0) from DetalleVentas) [TotalVenta],
	(select COUNT(*) from tb_Producto)[TotalProducto]
END
GO

/*--------------------------PROCEDURE REPORTE DE VENTAS------------------------------*/
CREATE OR ALTER PROC SP_REPORTE_VENTAS(
    @fechainicio VARCHAR(10),
    @fechafin VARCHAR(10),
    @idventa VARCHAR(50) = NULL
)
AS
BEGIN
    SET DATEFORMAT dmy;

    SELECT 
        CONVERT(char(10), V.FechaVenta, 103) AS [FechaVentas],
        CONCAT(C.Nombre, ' ', C.Apellido) AS [Cliente],
        P.Nombre AS [Producto],
        P.Precio,
        DV.Cantidad,
        DV.SubTotal,
        V.VentaID
    FROM DetalleVentas DV
    INNER JOIN tb_Producto P ON P.ProductoID = DV.ProductoID
    INNER JOIN tb_Ventas V ON V.VentaID = DV.VentaID
    INNER JOIN Tb_Cliente C ON C.ClienteID = DV.ClienteID
    WHERE CONVERT(date, V.FechaVenta, 103) BETWEEN CONVERT(date, @fechainicio, 103) AND CONVERT(date, @fechafin, 103)
    AND (@idventa IS NULL OR V.VentaID = @idventa);
END
GO

EXEC DBO.SP_REPORTE_VENTAS @fechainicio = '10/01/2024', @fechafin = '20/12/2024', @idventa = '8'
GO

/********************PROCEDURE LOGIN**********************/
/*--------------------------PROCEDURE INSERTAR USUARIOS------------------------------*/
CREATE OR ALTER PROCEDURE RegistrarUsuario
    @Username NVARCHAR(50),
    @Contrasena NVARCHAR(256),
    @Email NVARCHAR(100)
AS
BEGIN
    DECLARE @RoleId INT;
    SELECT @RoleId = RoleId FROM Roles WHERE RoleName = 'Usuario';
    
    INSERT INTO Users (Username, Contrasena, Email, RoleId)
    VALUES (@Username, @Contrasena, @Email, @RoleId);
END
GO

/*--------------------------PROCEDURE INSERTAR ADMINITRADORES------------------------------*/
CREATE OR ALTER PROCEDURE RegistrarAdmin
    @Username NVARCHAR(50),
    @Contrasena NVARCHAR(256),
    @Email NVARCHAR(100)
AS
BEGIN
    DECLARE @RoleId INT;
    SELECT @RoleId = RoleId FROM Roles WHERE RoleName = 'Administrador';
    
    INSERT INTO Users (Username, Contrasena, Email, RoleId)
    VALUES (@Username, @Contrasena, @Email, @RoleId);
END
GO

/*--------------------------PROCEDURES LISTAR LOGIN------------------------------*/
CREATE OR ALTER PROCEDURE LISTAR_LOGIN
    @Usuario NVARCHAR(50),
    @Contrasena NVARCHAR(256)
AS
BEGIN
    SELECT u.UserId, u.Username, u.Email, r.RoleId, r.RoleName
    FROM Users u
    JOIN Roles r ON u.RoleId = r.RoleId
    WHERE u.Username = @Usuario AND u.Contrasena = @Contrasena;
END
GO

/********************PROCEDURES CATEGORIA**********************/
/*--------------------------PROCEDURES LISTAR CATEGORIA------------------------------*/

CREATE OR ALTER PROCEDURE SP_LISTAR_CATEGORIA
AS
BEGIN
    SELECT 
        CategoriaID,
        Nombre
    FROM tb_Categoria
END
GO

/********************PROCEDURES CARGOS**********************/
/*--------------------------PROCEDURES LISTAR CARGOS------------------------------*/
CREATE OR ALTER PROCEDURE SP_LISTAR_CARGO
AS
BEGIN
    SELECT 
        CargoID,
        NomCargo,
        Descripcion
    FROM tb_Cargo
END
GO

/*--------------------------EJECUTABLES------------------------------*/
--EXEC RegistrarAdmin 'admin', 'admin_password', 'admin@example.com';
--GO

--EXEC RegistrarUsuario 'user1', 'user1_password', 'user1@example.com';
--GO

--EXEC RegistrarUsuario 'user2', 'user2_password', 'user2@example.com';
--GO

--EXEC LISTAR_LOGIN 'user2', 'user2_password';
--GO

--Select * from Users

--SELECT UserId, Username, Contrasena, Email FROM Users WHERE Username = 'user2'
--GO

--SELECT u.UserId, u.Username, u.Email, r.RoleId, r.RoleName
--FROM Users u
--JOIN Roles r ON u.RoleId = r.RoleId
--WHERE u.Username = 'user2' AND u.Contrasena = 'user2_password'
--GO

--DECLARE @Usuario NVARCHAR(50);
--DECLARE @Contrasena NVARCHAR(256);

--SET @Usuario = 'user2';
--SET @Contrasena = 'user2_password';
--EXEC LISTAR_LOGIN @Usuario, @Contrasena;

