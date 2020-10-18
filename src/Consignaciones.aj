import java.util.List;

import ejemplo.cajero.control.Comando;
import ejemplo.cajero.control.ComandoConsignar;

public aspect Consignaciones {
	pointcut menuConsignaciones() : call ( * ejemplo.cajero.Cajero.cargaComandos());

	after() returning(List<Comando> resultado): menuConsignaciones() {
		resultado.add(new ComandoConsignar());
	}
}