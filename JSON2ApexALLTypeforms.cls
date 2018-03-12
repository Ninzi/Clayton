public class JSON2ApexALLTypeforms {

	public class JSON2ApexALLTypeform {
		public String id;
		public String name;
	}

	
	public static List<JSON2ApexALLTypeform> parse(String json) {
		return (List<JSON2ApexALLTypeform>) System.JSON.deserialize(json, List<JSON2ApexALLTypeform>.class);
	}
}