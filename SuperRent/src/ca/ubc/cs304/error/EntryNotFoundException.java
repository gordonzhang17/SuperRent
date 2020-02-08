package ca.ubc.cs304.error;

public class EntryNotFoundException extends Exception {
	private static final long serialVersionUID = 7718828512143293558L;
	

	public EntryNotFoundException() {
		super();
	}

	public EntryNotFoundException(String message, Throwable cause) {
		super(message, cause);
	}

	public EntryNotFoundException(String message) {
		super(message);
	}

	public EntryNotFoundException(Throwable cause) {
		super(cause);
	}
}