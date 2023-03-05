import java.net.ServerSocket;
import java.io.*;
import java.net.Socket;
import java.util.Random;

public class LoadBalancer extends Thread{
	static String hosts[] = {"localhost", "localhost"};
	static int ports[] = {8081,8082};
	static int nbHosts = 2;
	static Random rand = new Random();
	
	Socket input;
	
	public LoadBalancer(Socket s) { input = s;}
	
	public static void main(String[] args) {
		try {
			ServerSocket ss = new ServerSocket(8080);
			System.out.println("LoadBalancer ss est prêt ...");
			while (true) {
				Thread t = new LoadBalancer(ss.accept());
				t.start();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void run () {
		try {
			System.out.println("run");
			int numPort = rand.nextInt(nbHosts);
			int port = ports[numPort];
			String host = hosts[numPort];
			Socket s = new Socket(host,port);
			
			OutputStream os = s.getOutputStream();
			InputStream is = s.getInputStream();
			
			OutputStream ois = input.getOutputStream();
			InputStream iis = input.getInputStream();
			
			byte [] buffer = new byte [1024];
			int bytesRead;
			
			bytesRead = iis.read(buffer);
			os.write(buffer, 0, bytesRead);
			
			bytesRead = is.read(buffer);
			ois.write(buffer, 0, bytesRead);
			
			is.close();
			os.close();
			ois.close();
			iis.close();
			input.close();
			s.close();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}


