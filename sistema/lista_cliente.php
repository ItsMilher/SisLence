<?php include_once "includes/header.php"; ?>

<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<div class="d-sm-flex align-items-center justify-content-between mb-4">
		<h1 class="h3 mb-0 text-gray-800">Clientes</h1>
		<a href="registro_cliente.php" class="btn btn-primary">Nuevo</a>
	</div>

	<div class="row">
		<div class="col-lg-12">

			<div class="table-responsive">
				<table class="table table-striped table-bordered" id="table">
					<thead class="thead-dark">
						<tr>
							<th>ID</th>
							<th>DNI</th>
							<th>NOMBRE</th>
							<th>TELEFONO</th>
							<th>DIRECCIÓN</th>
							<th>CRÉDITO</th>
							<?php if ($_SESSION['rol'] == 1) { ?>
							<th>ACCIONES</th>
							<?php } ?>
						</tr>
					</thead>
					<tbody>
						<?php
						include "../conexion.php";

						$query = mysqli_query($conexion, "SELECT * FROM cliente");
						$result = mysqli_num_rows($query);
						if ($result > 0) {
							while ($data = mysqli_fetch_assoc($query)) { ?>
								<tr>
									<td><?php $idCliente = $data['idcliente']; echo $idCliente; ?></td>
									<td><?php echo $data['dni']; ?></td>
									<td><?php echo $data['nombre']; ?></td>
									<td><?php echo $data['telefono']; ?></td>
									<td><?php echo $data['direccion']; ?></td>
									<td>
										<?php 
										$queryCredito = mysqli_query($conexion, "SELECT sum(f.credito) as credito
										FROM cliente c inner join factura f on idcliente = codcliente where codcliente=$idCliente;");
										
										$credito = 0;
										while ($dataC = mysqli_fetch_assoc($queryCredito)) {
											$credito = $dataC['credito'];
											if (!is_numeric($credito)) {
												$credito = 0;	
											}
										}
										$queryC = mysqli_query($conexion, "UPDATE cliente set credito = $credito where idcliente = $idCliente");
										?>
										<!-- Button trigger modal -->
										<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal<?php echo $idCliente; ?>">Ver</button>

										<!-- Modal -->
										<div class="modal fade" id="exampleModal<?php echo $idCliente;?>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="exampleModalLabel">Pagar Crédito</h5>
												<button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
											</div>
											<div class="modal-body">
												<strong> Deuda pendiente de:&nbsp; <?php echo $data['nombre']; ?>.</strong><br>
												<strong> Monto actual:&nbsp; <?php echo $data['credito']; ?>.</strong><br>
												<input type="number" name="pagar" id="pagar<?php echo $idCliente;?>" value="">
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
												<button type="button" class="btn btn-primary" onclick="pagarCredito(<?php echo $idCliente;?>, )"> Pagar crédito</button>
											</div>
											</div>
										</div>
										</div>						
									</td>									
									<?php if ($_SESSION['rol'] == 1) { ?>
									<td>
										<a href="editar_cliente.php?id=<?php echo $data['idcliente']; ?>" class="btn btn-success"><i class='fas fa-edit'></i></a>
										<form action="eliminar_cliente.php?id=<?php echo $data['idcliente']; ?>" method="post" class="confirmar d-inline">
											<button class="btn btn-danger" type="submit"><i class='fas fa-trash-alt'></i> </button>
										</form>
									</td>
									<?php } ?>
								</tr>
						<?php }
						} ?>
					</tbody>

				</table>
			</div>

		</div>
	</div>


</div>
<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->


<?php include_once "includes/footer.php"; ?>
