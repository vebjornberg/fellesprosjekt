package tests;

import java.io.IOException;

import client.ServerCodes;
import client.TCPClient;

public class GetRoomsTest {

	public static void main(String[] args) throws IOException {
		TCPClient client = new TCPClient();
		
		System.out.println(client.customQuery(ServerCodes.GetFilteredRooms, "250120151245, 250120151415, 12"));
	}
	
	
}
