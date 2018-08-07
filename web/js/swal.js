/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function entregarProducto(){
swal({
  title: "¿Desea Entregar Producto?",
  text: "Se solicitará confirmación del usuario!",
  icon: "warning",
  buttons: true,
  dangerMode: true,
})
.then((willDelete) => {
  if (willDelete) {
    swal("Producto entregado!", {
      icon: "success",
    });
  } else {
    swal("Producto no entregado!");
  }
});
}

function recibirProducto(){
    swal({
        title: "¿Ha recibido el Producto?",
        text: "Se registrará el usuario y la fecha de entrega!",
        icon: "warning",
        buttons: true,
        dangerMode: true,
    })
            .then((willDelete) => {
                if (willDelete) {
                    swal("Producto recibido!", {
                        icon: "success"
                    });
                    document.formActualiza.submit() 
                } else {
                    
                    swal("Producto no entregado!");
                     
                }
            });
//Comparacional
//Fin del método
}

function validaEntrega() {
    
    swal("Desea entregar el producto?", {
  buttons: {
    cancel: "Cancelar",
    value: false
    catch: {
      text: "Entregar",
      value: true
    }
  },
});


}