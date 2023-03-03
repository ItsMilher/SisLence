<?php include_once "includes/header.php";
include "../conexion.php";
if (!empty($_POST)) {
  $alert = "";
  if (empty($_POST['nombre']) || empty($_POST['telefono']) || empty($_POST['productos']) || empty($_POST['pago'])){
    $alert = '<p class"error">Todo los campos son requeridos</p>';
  } else {
    $idcliente = $_POST['id'];
    $dni = $_POST['dni'];
    $nombre = $_POST['nombre'];
    $telefono = $_POST['telefono'];
    $productos = $_POST['productos'];
    $pago = $_POST['pago'];

    $result = 0;
    if (is_numeric($dni) and $dni != 0) {

      $query = mysqli_query($conexion, "SELECT * FROM cliente_a_credito where (dni = '$dni' AND idcliente != $idcliente)");
      $result = mysqli_fetch_array($query);
      $resul = mysqli_num_rows($query);
    }

    if ($resul >= 1) {
      $alert = '<p class"error">El ____ ya existe</p>';
    } else {
      if ($dni == '') {
        $dni = 0;
      }
      $sql_update = mysqli_query($conexion, "UPDATE cliente_a_credito SET dni = '$dni',  nombre = '$nombre' , telefono = '$telefono', productos = '$productos', pago='$pago' WHERE idcliente = $idcliente");

      if ($sql_update) {
        $alert = '<p class"exito">Cliente Actualizado correctamente</p>';
      } else {
        $alert = '<p class"error">Error al Actualizar el Cliente</p>';
      }
    }
  }
}
// Mostrar Datos
if (empty($_REQUEST['id'])) {
  header("Location: lista_cliente_credito.php");
$idcliente = $_REQUEST['id'];
$sql = mysqli_query($conexion, "SELECT * FROM cliente_a_credito WHERE idcliente = $idcliente");
$result_sql = mysqli_num_rows($sql);
if ($result_sql == 0) {
  header("Location: lista_cliente_credito.php");
} else 
  while ($data = mysqli_fetch_array($sql)) {
    $idcliente = $data['idcliente'];
    $dni = $data['dni'];
    $nombre = $data['nombre'];
    $telefono = $data['telefono'];
    $productos = $data['producto'];
    $pago = $data['pago'];
  }
}
?>
        <!-- Begin Page Content -->
        <div class="container-fluid">

          <div class="row">
            <div class="col-lg-6 m-auto">

              <form class="" action="" method="post">
                <?php echo isset($alert) ? $alert : ''; ?>
                <input type="hidden" name="id" value="<?php echo $idcliente; ?>">
                <div class="form-group">
                  <label for="dni">Dni</label>
                  <input type="number" placeholder="Ingrese dni" name="dni" id="dni" class="form-control" value="<?php echo $dni; ?>">
                </div>

                <div class="form-group">
                  <label for="nombre">Nombre</label>
                  <input type="text" placeholder="Ingrese Nombre" name="nombre" class="form-control" id="nombre" value="<?php echo $nombre; ?>">
                </div>

                <div class="form-group">
                  <label for="telefono">Teléfono</label>
                  <input type="number" placeholder="Ingrese Teléfono" name="telefono" class="form-control" id="telefono" value="<?php echo $telefono; ?>">
                </div>


                <div class="form-group">
                  <label for="productos">Productos</label>
                  <input type="text" placeholder="Ingrese productos" name="productos" class="form-control" id="productos" value="<?php echo $productos; ?>">
                </div>


                <div class="form-group">
                    <label for="pago">pago</label>
                    <input type="text" placeholder="Ingrese monto" name="pago" class="form-control"  id="pago"  value="<?php echo $pago;?>" >
                </div>
                <button type="submit" class="btn btn-primary"><i class="fas fa-user-edit"></i> Editar Cliente</button>
              </form>
            </div>
          </div>


        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->
      <?php include_once "includes/footer.php"; ?>