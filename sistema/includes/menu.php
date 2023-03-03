<!-- Sidebar -->
<ul class="navbar-nav bg-color9 sidebar sidebar-dark accordion" id="accordionSidebar">

	<!-- Sidebar - Brand -->
	<a class="sidebar-brand d-flex align-items-center justify-content-center bg-color9" href="">
		<div class="sidebar-brand-icon rotate-n-15">
			<img src="img/logo.jpeg" class="img-thumbnail">
		</div>
		<div class="sidebar-brand-text mx-3">LENCERIA MAHAL <h5 class="sidebar-heading" >&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; & Fashion</h5></div>
		
	</a>

	<!-- Divider -->
	<hr class="sidebar-divider my-0">

	<!-- Divider -->
	<hr class="sidebar-divider">

	<!-- Heading -->
	<div class="sidebar-heading">
		Interface
	</div>

	 <!-- Item Inicio -->

	<li class="nav-item">
	<a class="nav-link collapsed"  href="index.php">		
	<i class="fas fa-home"></i>
	
			<span>Inicio</span>
			
		</a>

	<!-- Nav Item - Pages Collapse Menu -->
	<li class="nav-item">
		<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
		<i class="fas fa-cart-shopping"></i>
			<span>Ventas</span>
			<span class="badge bg-color4 text-c2"><?php echo $data['ventas']; ?></span>
		</a>
		<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<a class="collapse-item" href="nueva_venta.php">Nueva venta</a>
				<a class="collapse-item" href="ventas.php">Ventas</a>
			</div>
		</div>
	</li>

	<!-- Nav Item - Productos Collapse Menu -->
	<li class="nav-item">
		<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities" aria-expanded="true" aria-controls="collapseUtilities">
			<i class="fas fa-fw fa-wrench"></i>
			<span>Productos</span>
			<span class="badge bg-color3 text-c2"><?php echo $data['productos'];?></span>
		</a>
		<div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<a class="collapse-item" href="registro_producto.php">Nuevo Producto</a>
				<a class="collapse-item" href="lista_productos.php">Productos</a>
			</div>
		</div>
	</li>

	<!-- Nav Item - Clientes Collapse Menu -->
	<li class="nav-item">
		<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseClientes" aria-expanded="true" aria-controls="collapseUtilities">
			<i class="fas fa-users"></i>
			<span>Clientes</span>
			<span class="badge bg-color2 text-c2"><?php echo $data['clientes'];?></span>
			
		</a>
		<div id="collapseClientes" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<a class="collapse-item" href="registro_cliente.php">Nuevo Clientes</a>
				<a class="collapse-item" href="lista_cliente.php">Clientes</a>
			</div>
		</div>
	</li>
	<?php if ($_SESSION['rol'] == 1) { ?>
	<!-- Nav Item - Utilities Collapse Menu -->
	<li class="nav-item">
		<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseProveedor" aria-expanded="true" aria-controls="collapseUtilities">
			<i class="fas fa-hospital"></i>
			<span>Proveedor</span>
			<span class="badge bg-color5 text-c2"><?php echo $data['proveedores']; ?></span>
		</a>
		<div id="collapseProveedor" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<a class="collapse-item" href="registro_proveedor.php">Nuevo Proveedor</a>
				<a class="collapse-item" href="lista_proveedor.php">Proveedores</a>
			</div>
		</div>
	</li>

	<?php } ?>
	
	<?php if ($_SESSION['rol'] == 1) { ?>
		<!-- Nav Item - Usuarios Collapse Menu -->
		<li class="nav-item">
			<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUsuarios" aria-expanded="true" aria-controls="collapseUtilities">
				<i class="fas fa-user"></i>
				<span>Usuarios</span>
				<span class="badge bg-color1 text-c2"><?php echo $data['usuarios']; ?></span>
			</a>
			<div id="collapseUsuarios" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
				<div class="bg-white py-2 collapse-inner rounded">
					<a class="collapse-item" href="registro_usuario.php">Nuevo Usuario</a>
					<a class="collapse-item" href="lista_usuarios.php">Usuarios</a>
				</div>
			</div>
		</li>
	<?php } ?>
	
	<div class="text-center d-none d-md-inline">
               <span> <button class="rounded-circle border-0 " id="sidebarToggle"></button></span>
            </div>
			

</ul>