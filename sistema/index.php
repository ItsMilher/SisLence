<?php include_once "includes/header.php"; ?>

<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<div class="d-sm-flex align-items-center justify-content-between mb-4">
		<h1 class="h3 mb-0 text-gray-800">Panel de Administración</h1>
	</div>

	<!-- Content Row -->
	<div class="row">
	<?php if ($_SESSION['rol'] == 1) { ?>
		<!-- Earnings (Monthly) Card Example -->
		<a class="col-xl-3 col-md-6 mb-4" href="lista_usuarios.php">
			<div class="card border-left-primary shadow h-100 py-2 bg-color1">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-c1 text-uppercase mb-1">Usuarios</div>
							<div class="h5 mb-0 font-weight-bold text-c1"><?php echo $data['usuarios']; ?></div>
							
						</div>
						<div class="col-auto">
							<i class="fas fa-user fa-2x text-c1"></i>
						</div>
					</div>
				</div>
			</div>
		</a>

		<!-- Earnings (Monthly) Card Example -->
		<a class="col-xl-3 col-md-6 mb-4 " href="lista_cliente.php">
			<div class="card border-left-success shadow h-100 py-2 bg-color2 text-c2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-c2 text-uppercase mb-1">Clientes</div>
							<div class="h5 mb-0 font-weight-bold text-c2"><?php echo $data['clientes']; ?></div>
						</div>
						<div class="col-auto">
							<i class="fas fa-users fa-2x  text-c1"></i>
						</div>
					</div>
				</div>
			</div>
		</a>

		<!-- Earnings (Monthly) Card Example -->
		<a class="col-xl-3 col-md-6 mb-4" href="lista_productos.php">
			<div class="card border-left-info shadow h-100 py-2 bg-color3">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-c2 text-uppercase mb-1">Productos</div>
							<div class="row no-gutters align-items-center">
								<div class="col-auto">
									<div class="h5 mb-0 mr-3 font-weight-bold text-c2"><?php echo $data['productos']; ?></div>
								</div>
								<div class="col">
									<div class="progress progress-sm mr-2">
										<div class="progress-bar bg-color2" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-clipboard-list fa-2x text-c2"></i>
						</div>
					</div>
				</div>
			</div>
		</a>

		<!-- Pending Requests Card Example -->
		<a class="col-xl-3 col-md-6 mb-4" href="ventas.php">
			<div class="card border-left-warning shadow h-100 py-2 bg-color4">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-c1 text-uppercase mb-1">Ventas</div>
							<div class="h5 mb-0 font-weight-bold text-c1"><?php echo $data['ventas']; ?></div>
						</div>
						<div class="col-auto">
							<i class="fas fa-dollar-sign fa-2x text-c1"></i>
						</div>
					</div>
				</div>
			</div>
		</a>

	<!-- Pending Requests Card Example -->
	<a class="col-xl-3 col-md-6 mb-4" href="lista_proveedor.php">
			<div class="card border-left-warning shadow h-100 py-2 bg-color5">
				<div class="card-body">
					<div class="row no-gutters align-items-center ">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-c1 text-uppercase mb-1">Proveedor</div>
							<div class="h5 mb-0 font-weight-bold text-c1"><?php echo $data['proveedores']; ?></div>
						</div>
						<div class="col-auto">
							<i class="fas fa-store-alt fa-2x text-c1"></i>
						</div>
					</div>
				</div>
			</div>
		</a>

			<!-- Pending Requests Card Example -->
			<a class="col-xl-3 col-md-6 mb-4" href="ventas.php">
			<div class="card border-left-warning shadow h-100 py-2 bg-color6">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-c1 text-uppercase mb-2">Ganancias</div>
							<div class="h5 mb-0 font-weight-bold text-c1"><?php echo $data['ventas']; ?></div>
						</div>
						<div class="col-auto">
						<i class="fa-solid fa-signal-bars"></i>
							<i class="fas fa-signal fa-2x  text-c1"></i>
						</div>
					</div>
				</div>
			</div>
		</a>

			<!-- Pending Requests Card Example -->
			<a class="col-xl-3 col-md-6 mb-4" href="ventas.php">
			<div class="card border-left-warning shadow h-100 py-2 bg-color7">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-c2 text-uppercase mb-1">COMPRAS</div>
							<div class="h5 mb-0 font-weight-bold text-c1"><?php echo $data['ventas']; ?></div>
						</div>
						<div class="col-auto">
							<i class="fas fa-truck fa-2x text-c1"></i>
						</div>
					</div>
				</div>
			</div>
		</a>
		<!-- Earnings (Monthly) Card Example -->
		<a class="col-xl-3 col-md-6 mb-4" href="lista_usuarios.php">
			<div class="card border-left-primary shadow h-100 py-2 bg-color8">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-primary text-uppercase mb-1">total de dinero</div>
							<div class="h5 mb-0 font-weight-bold text-gray-800"><?php echo $data['ventas']; ?></div>
						</div>
						<div class="col-auto">
							<i class="fas fa-money-bill fa-2x text-c1"></i>
						</div>
					</div>
				</div>
			</div>
		</a>

		<?php } else { ?>


		<!-- Earnings (Monthly) Card Example -->
		<a class="col-xl-3 col-md-6 mb-4 " href="lista_cliente.php">
			<div class="card border-left-success shadow h-100 py-2 bg-color2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-c2 text-uppercase mb-1">Clientes</div>
							<div class="h5 mb-0 font-weight-bold text-c2"><?php echo $data['clientes']; ?></div>
						</div>
						<div class="col-auto">
							<i class="fas fa-users fa-2x text-gray-300"></i>
						</div>
					</div>
				</div>
			</div>
		</a>


		
		<!-- Earnings (Monthly) Card Example -->
		<a class="col-xl-3 col-md-6 mb-4" href="lista_productos.php">
			<div class="card border-left-info shadow h-100 py-2 bg-color3">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-c2 text-uppercase mb-1">Productos</div>
							<div class="row no-gutters align-items-center">
								<div class="col-auto">
									<div class="h5 mb-0 mr-3 font-weight-bold text-c2"><?php echo $data['productos']; ?></div>
								</div>
								<div class="col">
									<div class="progress progress-sm mr-2">
										<div class="progress-bar bg-color2" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-clipboard-list fa-2x text-c2"></i>
						</div>
					</div>
				</div>
			</div>
		</a>

			<?php } ?>
	</div>


	
	<!-- Page Heading -->
	<div class="d-sm-flex align-items-center justify-content-between mb-4">
		<h1 class="h3 mb-0 text-gray-800">Configuración</h1>
	</div>
	<div class="row">
		<?php if ($_SESSION['rol'] == 1) { ?>
		<div class="col-lg-6">
			<div class="card">
			
				<div class="card-header bg-color3 text-white">
					Información Personal
				</div>
				<div class="card-body">
			
					<div class="form-group">
						<label>Nombre: <strong><?php echo $_SESSION['nombre']; ?></strong></label>
					</div>
					<div class="form-group">
						<label>Correo: <strong><?php echo $_SESSION['email']; ?></strong></label>
					</div>
					<div class="form-group">
						<label>Rol: <strong><?php echo $_SESSION['rol_name']; ?></strong></label>
					</div>
					<div class="form-group">
						<label>Usuario: <strong><?php echo $_SESSION['user']; ?></strong></label>
					</div>

					<ul class="list-group">
						<li class="list-group-item active bg-color3">Cambiar Contraseña</li>
						<form action="" method=" post" name="frmChangePass" id="frmChangePass" class="p-3">
							<div class="form-group">
								<label>Contraseña Actual</label>
								<input type="password" name="actual" id="actual" placeholder="Clave Actual" required class="form-control">
							</div>
							<div class="form-group">
								<label>Nueva Contraseña</label>
								<input type="password" name="nueva" id="nueva" placeholder="Nueva Clave" required class="form-control">
							</div>
							<div class="form-group">
								<label>Confirmar Contraseña</label>
								<input type="password" name="confirmar" id="confirmar" placeholder="Confirmar clave" required class="form-control">
							</div>
							<div class="alertChangePass" style="display:none;">
							</div>
							<div>
								<button type="submit" class="btn btn-secondary btnChangePass bg-color3">Cambiar Contraseña</button>
							</div>
						</form>
					</ul>
				</div>
			</div>
		</div>
		
			<div class="col-lg-6">
				<div class="card">
					<div class="card-header bg-color3 text-white">
						Datos de la Empresa
					</div>
					<div class="card-body">
						<form action="empresa.php" method="post" id="frmEmpresa" class="p-3">
							<div class="form-group">
								<label>Ruc:</label>
								<input type="number" name="txtDni" value="<?php echo $dni; ?>" id="txtDni" placeholder="Dni de la Empresa" required class="form-control">
							</div>
							<div class="form-group">
								<label>Nombre:</label>
								<input type="text" name="txtNombre" class="form-control" value="<?php echo $nombre_empresa; ?>" id="txtNombre" placeholder="Nombre de la Empresa" required class="form-control">
							</div>
							<div class="form-group">
								<label>Razon Social:</label>
								<input type="text" name="txtRSocial" class="form-control" value="<?php echo $razonSocial; ?>" id="txtRSocial" placeholder="Razon Social de la Empresa">
							</div>
							<div class="form-group">
								<label>Teléfono:</label>
								<input type="number" name="txtTelEmpresa" class="form-control" value="<?php echo $telEmpresa; ?>" id="txtTelEmpresa" placeholder="teléfono de la Empresa" required>
							</div>
							<div class="form-group">
								<label>Correo Electrónico:</label>
								<input type="email" name="txtEmailEmpresa" class="form-control" value="<?php echo $emailEmpresa; ?>" id="txtEmailEmpresa" placeholder="Correo de la Empresa" required>
							</div>
							<div class="form-group">
								<label>Dirección:</label>
								<input type="text" name="txtDirEmpresa" class="form-control" value="<?php echo $dirEmpresa; ?>" id="txtDirEmpresa" placeholder="Dirreción de la Empresa" required>
							</div>
							<div class="form-group">
								<label>IGV (%):</label>
								<input type="text" name="txtIgv" class="form-control" value="<?php echo $igv; ?>" id="txtIgv" placeholder="IGV de la Empresa" required>
							</div>
							<?php echo isset($alert) ? $alert : ''; ?>
							<div>
								<button type="submit" class="btn btn-primary btnChangePass bg-color3"><i class="fas fa-save"></i> Guardar Datos</button>
							</div>

						</form>
					</div>
				</div>
			</div>
		<?php } else { ?>

			<div class="col-lg-6">
			<div class="card">
			
				<div class="card-header bg-color3 text-white">
					Información Personal
				</div>
				<div class="card-body">
			
					<div class="form-group">
						<label>Nombre: <strong><?php echo $_SESSION['nombre']; ?></strong></label>
					</div>
					<div class="form-group">
						<label>Correo: <strong><?php echo $_SESSION['email']; ?></strong></label>
					</div>
					<div class="form-group">
						<label>Rol: <strong><?php echo $_SESSION['rol_name']; ?></strong></label>
					</div>
					<div class="form-group">
						<label>Usuario: <strong><?php echo $_SESSION['user']; ?></strong></label>
					</div>

				</div>
			</div>
		</div>
			<div class="col-lg-6">
				<div class="card">
					<div class="card-header bg-primary text-white">
						Datos de la Empresa
					</div>
					<div class="card-body">
						<div class="p-3">
							<!-- <div class="form-group">
								<strong>Ruc:</strong>
								<h6><?php echo $dni; ?></h6>
							</div> -->
							<div class="form-group">
								<strong>Nombre:</strong>
								<h6><?php echo $nombre_empresa; ?></h6>
							</div>
							<!-- <div class="form-group">
								<strong>Razon Social:</strong>
								<h6><?php echo $razonSocial; ?></h6>
							</div> -->
							<div class="form-group">
								<strong>Teléfono:</strong>
								<?php echo $telEmpresa; ?>
							</div>
							<div class="form-group">
								<strong>Correo Electrónico:</strong>
								<h6><?php echo $emailEmpresa; ?></h6>
							</div>
							<div class="form-group">
								<strong>Dirección:</strong>
								<h6><?php echo $dirEmpresa; ?></h6>
							</div>
							<!-- <div class="form-group">
								<strong>IGV (%):</strong>
								<h6><?php echo $igv; ?></h6>
							</div> -->

						</div>
					</div>
				</div>
			</div>
			

		<?php } ?>
	</div>


</div>
<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->


<?php include_once "includes/footer.php"; ?>