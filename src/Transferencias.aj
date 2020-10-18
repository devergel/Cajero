import ejemplo.cajero.control.ComandoTransferir;

import java.util.List;

import ejemplo.cajero.control.Comando;

public aspect Transferencias {
	pointcut menuTransferencias() : call ( * ejemplo.cajero.Cajero.cargaComandos());

	after() returning(List<Comando> comandos): menuTransferencias() {
		comandos.add(new ComandoTransferir());
	}
	
}