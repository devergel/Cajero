import java.util.Date;

import org.aspectj.lang.reflect.CodeSignature;

public aspect ListadoOperaciones {

	StringBuilder logDia = new StringBuilder();

	public ListadoOperaciones() {
		super();
		logDia.append("Log del dia ");
		logDia.append(new Date());
		logDia.append("\n");
	}

	pointcut comandos() : call ( * ejemplo.cajero.modelo.Cuenta.*(..));
	
	before(): comandos() {
		logDia.append("Ejectando\n");
		logDia.append("\t objeto     : ");
		logDia.append(thisJoinPoint.getTarget().getClass().getSimpleName());
		logDia.append("\n");
		logDia.append("\t método     : ");
		logDia.append(thisJoinPoint.getSignature().getName());
		logDia.append("\n");
		logDia.append("\t estado     : ");
		logDia.append(thisJoinPoint.getTarget());
		logDia.append("\n");
		if(thisJoinPoint.getArgs()!=null&&thisJoinPoint.getArgs().length>0)
		{
			logDia.append("\t argumentos : ");
			Object getargs[] = thisJoinPoint.getArgs();
			CodeSignature codeSignature = (CodeSignature) thisJoinPoint.getSignature();
			String[] argNames = codeSignature.getParameterNames();
			logDia.append(arguments(argNames,getargs));
		}
		logDia.append("\n");
	}

	pointcut mostrarLog() : call ( * ejemplo.cajero.Cajero.exitMesaje(..));

	before(): mostrarLog() {
		System.out.println(logDia);
	}

	protected String arguments(Object[] names, Object[] values) {
		StringBuilder logDia = new StringBuilder();
		for (int i = 0; i < names.length; i++) {
			logDia.append((i > 0 ? ", " : ""));
			logDia.append(names[i]);
			logDia.append(" = ");
			logDia.append(values[i].toString());
		}
		return logDia.toString();
	}
}
