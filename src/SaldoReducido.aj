import ejemplo.cajero.modelo.Cuenta;

public aspect SaldoReducido {
	pointcut saldoMinimo() : call ( * ejemplo.cajero.modelo.Cuenta.retirar(..));

	before() throws Exception : saldoMinimo() {
		Cuenta cuenta=(Cuenta)thisJoinPoint.getTarget();
		long saldo = cuenta.getSaldo() - Integer.parseInt(thisJoinPoint.getArgs()[0].toString());
		if (saldo < 200) {
			throw new Exception("Saldo Reducido. No se permite un saldo inferior a 200 para esta cuenta");
		}
	}
}