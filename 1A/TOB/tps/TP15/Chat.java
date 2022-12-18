import java.util.List;
import java.util.ArrayList;
import java.util.Collections;
import java.util.*;

public class Chat extends Observable implements Iterable<Message>  {

	private List<Message> messages;

	public Chat() {
		this.messages = new ArrayList<Message>();
	}

	public void ajouter(Message m) {
		this.messages.add(m);
	}
	
	public Iterator<Message> iterator() {
	    return this.messages.listIterator();
	}
	
	public void actualiser(Message m) {
	    this.messages.add(m);
	}
	
}
