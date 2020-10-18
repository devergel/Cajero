import java.util.Date;

import org.aspectj.lang.reflect.CodeSignature;

public aspect Auditoria {

	pointcut auditoria() : call ( * ejemplo.cajero.modelo.Cuenta.*(..)) || call ( * ejemplo.cajero.modelo.Banco.*(..)) || call( * ejemplo.cajero.control.Comando.ejecutar(..));
	
	before(): auditoria() {
		StringBuilder auditoria = new StringBuilder();
		auditoria.append(new Date());
		auditoria.append(" Ejectando\n");
		auditoria.append("\t objeto     : ");
		auditoria.append(thisJoinPoint.getTarget().getClass().getSimpleName());
		auditoria.append("\n");
		auditoria.append("\t método     : ");
		auditoria.append(thisJoinPoint.getSignature().getName());
		auditoria.append("\n");
		auditoria.append("\t estado     : ");
		auditoria.append(thisJoinPoint.getTarget());
		auditoria.append("\n");
		if(thisJoinPoint.getArgs()!=null&&thisJoinPoint.getArgs().length>0)
		{
			auditoria.append("\t argumentos : ");
			Object getargs[] = thisJoinPoint.getArgs();
			CodeSignature codeSignature = (CodeSignature) thisJoinPoint.getSignature();
			String[] argNames = codeSignature.getParameterNames();
			auditoria.append(arguments(argNames,getargs));
		}
		auditoria.append("\n");
		System.out.println(auditoria.toString());
	}
	
	protected String arguments(Object[] names, Object[] values) {
		StringBuilder auditoria = new StringBuilder();
		for (int i = 0; i < names.length; i++) {
			auditoria.append((i > 0 ? ", " : ""));
			auditoria.append(names[i]);
			auditoria.append(" = ");
			auditoria.append(values[i].toString());
		}
		return auditoria.toString();
	}
}