using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data;
using MySql.Data.MySqlClient;
using System.Data.SqlClient;

namespace BD_aplikacja
{
    public partial class Klient : Form
    {
        public Klient()
        {
            InitializeComponent();
        }

        String serwer = "127.0.0.1";
        String user = "root";
        String pass = "ubuntu";
        String database = "restauracja";

        int kategoria;
        int id_dania;
        int id_zamowienia = 1;
        int kosztZamowienia = 0;


        // przycisk rozpocznij
        private void button3_Click_1(object sender, EventArgs e)
        {
            listView1.Items.Clear();
            listView2.Items.Clear();
            listView3.Items.Clear();
            listView4.Items.Clear();
            string logowanie = "server=" + serwer + ";" + "uid=" + user + ";" +
                    "pwd=" + pass + ";" + "database=" + database + ";";

            // pokazanie kategorii
            try
            {

                string Query = "SELECT Nazwa_typu_dania FROM restauracja.`typy dan`;";
                MySqlConnection MyConn2 = new MySqlConnection(logowanie);
                MySqlCommand MyCommand2 = new MySqlCommand(Query, MyConn2);



                //For offline connection we weill use  MySqlDataAdapter class.  
                MyConn2.Open();
                MySqlDataAdapter MyAdapter = new MySqlDataAdapter();
                MyAdapter.SelectCommand = MyCommand2;

                DataSet ds = new DataSet();
                MyAdapter.Fill(ds);

                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    ListViewItem item = new ListViewItem(dr["Nazwa_typu_dania"].ToString());
                    listView1.Items.Add(item);
                }

                MyConn2.Close();



            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

            // init insert
            try
            {

               // string MyConnection2 = "datasource=127.0.0.1;username=root;password=ubuntu";
                string Query = "INSERT INTO `restauracja`.`zamowienia` (`Zlozono`, `Wydano`, `Czy_reklamacja`, `Razem`, `Klienci_ID_klienta`, `Pracownicy_ID_pracownika`) VALUES('2017-06-03 12:10:07', '0001-01-01 01:01:01', '0', '0', '1', '201');";

                MySqlConnection MyConn2 = new MySqlConnection(logowanie);
                MySqlCommand MyCommand2 = new MySqlCommand(Query, MyConn2);
                MySqlDataReader MyReader2;
                MyConn2.Open();
                MyReader2 = MyCommand2.ExecuteReader();     // Here our query will be executed and data saved into the database.  
                MyConn2.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

            // pobierz numer ostatniego zamówienia
            try
            {
                //Display query  
                string Query = "SELECT ID_zamowienia FROM restauracja.zamowienia ORDER BY ID_zamowienia desc limit 1; ";
                MySqlConnection MyConn2 = new MySqlConnection(logowanie);
                MySqlCommand MyCommand2 = new MySqlCommand(Query, MyConn2);
                MyConn2.Open();

                MySqlDataReader war = MyCommand2.ExecuteReader();
                if (war.HasRows)
                {
                    war.Read();
                    id_zamowienia = war.GetInt32(0);
                }

                MyConn2.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            // bestsellery
            try
            {
                string Query = "SELECT Nazwa_dania, Cena  FROM restauracja.dania JOIN `restauracja`.`zamowienia_has_dania` ON Dania_ID_Dania = ID_Dania group by Nazwa_dania order by count(Nazwa_dania) desc limit 10";

                MySqlConnection MyConn2 = new MySqlConnection(logowanie);
                MySqlCommand MyCommand2 = new MySqlCommand(Query, MyConn2);

                MyConn2.Open();
                MySqlDataAdapter MyAdapter = new MySqlDataAdapter();
                MyAdapter.SelectCommand = MyCommand2;

                DataSet ds = new DataSet();
                MyAdapter.Fill(ds);

                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    ListViewItem item = new ListViewItem(dr["Nazwa_dania"].ToString());
                    item.SubItems.Add(dr["Cena"].ToString());

                    listView4.Items.Add(item);
                }

                MyConn2.Close();

                
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

            panel3.SendToBack();
            panel2.BringToFront();

            panel1.Visible = false;
        }

        // lista kategorii
        private void listView1_Click(object sender, EventArgs e)
        {
            string logowanie = "server=" + serwer + ";" + "uid=" + user + ";" +
                     "pwd=" + pass + ";" + "database=" + database + ";";
            kategoria = listView1.SelectedIndices[0] + 1;

            try
            {
                
                listView2.Items.Clear();
                string Query = "SELECT Nazwa_dania, Cena, Ilosc_kalorii, Czas_oczekiwania FROM restauracja.dania WHERE `Typy dan_ID_Typu_dania` = " + kategoria + " ;";
                MySqlConnection MyConn2 = new MySqlConnection(logowanie);
                MySqlCommand MyCommand2 = new MySqlCommand(Query, MyConn2);


                //For offline connection we weill use  MySqlDataAdapter class.  
                MyConn2.Open();
                MySqlDataAdapter MyAdapter = new MySqlDataAdapter();
                MyAdapter.SelectCommand = MyCommand2;

                DataSet ds = new DataSet();
                MyAdapter.Fill(ds);

                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    ListViewItem item = new ListViewItem(dr["Nazwa_dania"].ToString());
                    item.SubItems.Add(dr["Cena"].ToString());
                    item.SubItems.Add(dr["Ilosc_kalorii"].ToString());
                    item.SubItems.Add(dr["Czas_oczekiwania"].ToString());

                    listView2.Items.Add(item);
                }

                MyConn2.Close();



            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
      
        // przycisk skladania zamowienia
        private void button2_Click(object sender, EventArgs e)
        {
            panel3.BringToFront();
        }

        // dodanie dania do zamówienia
        private void listView2_DoubleClick(object sender, EventArgs e)
        {
            string logowanie = "server=" + serwer + ";" + "uid=" + user + ";" +
                    "pwd=" + pass + ";" + "database=" + database + ";";
            id_dania =  (kategoria * 100) + (listView2.SelectedIndices[0] + 1);

            try
            {
                // zapytanie query
                string Query = "INSERT INTO `restauracja`.`zamowienia_has_dania` (`Zamowienia_ID_zamowienia`, `Zamowienia_Klienci_ID_klienta`, `Zamowienia_Pracownicy_ID_pracownika`, `Dania_ID_dania`, `Dania_Typy dan_ID_Typu_dania`) VALUES('" + id_zamowienia + "', '1', '201', '" + id_dania + "', '" + kategoria + "');";

                MySqlConnection MyConn2 = new MySqlConnection(logowanie);
                MySqlCommand MyCommand2 = new MySqlCommand(Query, MyConn2);
                MySqlDataReader MyReader2;
                MyConn2.Open();
                MyReader2 = MyCommand2.ExecuteReader();     // Here our query will be executed and data saved into the database.  
                MyConn2.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

            try
            {
                listView3.Items.Clear();
                string Query = "SELECT Nazwa_dania, Cena FROM restauracja.dania JOIN `restauracja`.`zamowienia_has_dania` ON Dania_ID_Dania = ID_Dania WHERE Zamowienia_ID_zamowienia = " + id_zamowienia + ";";
                MySqlConnection MyConn2 = new MySqlConnection(logowanie);
                MySqlCommand MyCommand2 = new MySqlCommand(Query, MyConn2);

                
                MyConn2.Open();
                MySqlDataAdapter MyAdapter = new MySqlDataAdapter();
                MyAdapter.SelectCommand = MyCommand2;

                DataSet ds = new DataSet();
                MyAdapter.Fill(ds);

                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    ListViewItem item = new ListViewItem(dr["Nazwa_dania"].ToString());
                    item.SubItems.Add(dr["Cena"].ToString());

                    listView3.Items.Add(item);
                }

                MyConn2.Close();

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            // pokaż koszt całego zamówienia
            try
            {
                
                string Query = "SELECT SUM(Cena) FROM restauracja.dania JOIN zamowienia_has_dania ON Dania_ID_Dania = ID_Dania WHERE Zamowienia_ID_zamowienia = " + id_zamowienia.ToString() + ";";
                MySqlConnection MyConn2 = new MySqlConnection(logowanie);
                MySqlCommand MyCommand2 = new MySqlCommand(Query, MyConn2);

                
                MyConn2.Open();
                MySqlDataAdapter MyAdapter = new MySqlDataAdapter();
                MyAdapter.SelectCommand = MyCommand2;

                MySqlDataReader war = MyCommand2.ExecuteReader();
                if (war.HasRows)
                {
                    war.Read();
                    kosztZamowienia = war.GetInt32(0);
                }

                MyConn2.Close();

                label9.Text = kosztZamowienia.ToString();

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }




        }


        // //////////////////////////////////////////////////////
        // wybór rodzaju płatności
        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            MessageBox.Show("Zamówienie złożone.");
            panel3.SendToBack();
            panel1.BringToFront();
            panel1.Visible = true;
            
        }

        private void radioButton2_CheckedChanged(object sender, EventArgs e)
        {
            MessageBox.Show("Zamówienie złożone.");
            panel3.SendToBack();
            panel1.BringToFront();
            panel1.Visible = true;
            

        }

    }
}
