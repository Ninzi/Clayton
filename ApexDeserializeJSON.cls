public class ApexDeserializeJSON {

	public class Answers {
		public String textfield_62334344;
		public String email_62334414;
		public String list_62405912_choice;
		public String yesno_62405974;
	}

	public class Answers_Z {
		public String textfield_62334344;
		public String email_62334414;
		public String yesno_62405974;
	}

	public class Responses_Z {
		public String token;
		public String completed;
		public Metadata metadata;
		public List<Hidden> hidden;
		public Answers answers;
	}

	public class Stats {
		public Responses responses;
	}

	public class Metadata {
		public String date_land;
		public String date_submit;
		public String browser;
		public String platform;
		public String user_agent;
		public String referer;
		public String network_id;
	}

	public class Hidden {
	}

	public class Questions {
		public String id;
		public String question;
		public Integer field_id;
	}

	public class Answers_Y {
		public String textfield_62334344;
		public String email_62334414;
		public String list_62405912_choice;
	}

	public class ApexDeserializeJSONs {
		public Integer http_status;
		public Stats stats;
		public List<Questions> questions;
		public List<Responses_Z> responses;
	}

	public class Answers_X {
		public String textfield_62334344;
		public String email_62334414;
	}

	public class Answers_W {
		public String textfield_62334344;
	}

	public class Responses {
		public Integer showing;
		public Integer total;
		public Integer completed;
	}

	
	public static ApexDeserializeJSONs parse(String json) {
		return (ApexDeserializeJSONs) System.JSON.deserialize(json, ApexDeserializeJSONs.class);
	}
}