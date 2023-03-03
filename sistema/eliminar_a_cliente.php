<?php
if (!empty($_GET['id'])) {
    require("../conexion.php");
    $id = $_GET['id'];
    $query_delete = mysqli_query($conexion, "DELETE FROM cliente_a_credito WHERE idcliente = $id");
    mysqli_close($conexion);
    header("location: lista_a_cliente.php");
}
?>