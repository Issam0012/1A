import java.util.*;

public class Chat implements Iterable<Message>, Observer  {

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
	
	public void update(Message m) {
	    this.messages.add(m);
	}
	
}
