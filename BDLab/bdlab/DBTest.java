package bdlab;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

public class DBTest {
	public static class Pracownik {
		private String pesel;
		private String imie;
		private String nazwisko;
		private String mail;
		private String nr_telefonu;
		private String adres;
		private String stanowisko;

		public String getPesel() {
			return pesel;
		}

		public void setPesel(String pesel) {
			this.pesel = pesel;
		}

		public String getImie() {
			return imie;
		}

		public void setImie(String imie) {
			this.imie = imie;
		}

		public String getNazwisko() {
			return nazwisko;
		}

		public void setNazwisko(String nazwisko) {
			this.nazwisko = nazwisko;
		}

		public String getMail() {
			return mail;
		}

		public void setMail(String mail) {
			this.mail = mail;
		}

		public String getNr_telefonu() {
			return nr_telefonu;
		}

		public void setNr_telefonu(String nr_telefonu) {
			this.nr_telefonu = nr_telefonu;
		}

		public String getAdres() {
			return adres;
		}

		public void setAdres(String adres) {
			this.adres = adres;
		}

		public String getStanowisko() {
			return stanowisko;
		}

		public void setStanowisko(String stanowisko) {
			this.stanowisko = stanowisko;
		}

		public Pracownik() {
		}

		@Override
		public String toString() {
			return "Pracownik [pesel=" + pesel + ", imie=" + imie + ", nazwisko=" + nazwisko + ", mail=" + mail
					+ ", nr_telefonu=" + nr_telefonu + ", adres=" + adres + ", stanowisko=" + stanowisko + "]";
		}

	}

	public final static ResultSetToBean<Pracownik> pracownikConverter = new ResultSetToBean<Pracownik>() {
		public Pracownik convert(ResultSet rs) throws Exception {
			Pracownik e = new Pracownik();
			e.setPesel(rs.getString("PESEL"));
			e.setImie(rs.getString("IMIE"));
			e.setNazwisko(rs.getString("NAZWISKO"));
			e.setMail(rs.getString("MAIL"));
			e.setNr_telefonu(rs.getString("NR_TELEFONU"));
			e.setAdres(rs.getString("ADRES"));
			e.setStanowisko(rs.getString("STANOWISKO"));
			return e;
		}
	};

	public static void main(String[] args) {
		boolean result = DBManager.run(new Task<Boolean>() {
			public Boolean execute(PreparedStatement ps) throws Exception {
				ps.setString(1, "grafik");
				ps.setString(2, "80072909146");
				return ps.executeUpdate() > 0;
			}
		}, "update pracownik set stanowisko = ? where pesel = ?");

		System.out.println(result ? "Udalo sie" : "Nie udalo sie");
		
		boolean result3 = DBManager.run(new Task<Boolean>() {
			public Boolean execute(PreparedStatement ps) throws Exception {
				ps.setString(1, "78080517455");
				ps.setString(2, "Artur");
				ps.setString(3, "Korolczuk");
				ps.setString(4, "akorol@ineria.pl");
				ps.setString(5, "390152123");
				ps.setString(6, "ul. Marymoncka 17, Warszawa");
				ps.setString(7, "sprzedawca");
				return ps.executeUpdate() > 0;
			}
		}, "insert into pracownik values (?, ?, ?, ?, ?, ?, ?)");

		System.out.println(result3 ? "Udalo sie" : "Nie udalo sie");
		
		boolean result2 = DBManager.run(new Task<Boolean>() {
			public Boolean execute(PreparedStatement ps) throws Exception {
				ps.setString(1, "78080517455");
				return ps.executeUpdate() > 0;
			}
		}, "delete from pracownik where pesel = ?");

		System.out.println(result2 ? "Udalo sie" : "Nie udalo sie");
		

		List<Pracownik> pracownicy = DBManager
				.run(new Query() {
					public void prepareQuery(PreparedStatement ps)
							throws Exception {
						ps.setString(1, "grafik");
					}
				}, pracownikConverter,
						"select * from pracownik where stanowisko = ?");

		for (Pracownik e: pracownicy) {
			System.out.println(e);
		}
	}

}
