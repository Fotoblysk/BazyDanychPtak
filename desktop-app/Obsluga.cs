using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Data;
using MySql.Data;
using MySql.Data.MySqlClient;

namespace BD_aplikacja
{
    public partial class Obsluga : Form
    {
        String serwer = "127.0.0.1";
        String user = "root";
        String pass = "ubuntu";
        String database = "restauracja";

        public Obsluga()
        {
            InitializeComponent();
        }
        /*****************************************************/
        // panel WYBORU
        /*****************************************************/
        // przycisk PRACOWNIK
        private void button1_Click(object sender, EventArgs e)
        {
            panelObsluga.Visible = true;
            panelObsluga.BringToFront();
            panelWybor.Visible = false;
            panelWybor.SendToBack();

            listView1.Items.Clear();
            string logowanie = "server=" + serwer + ";" + "uid=" + user + ";" +
                 "pwd=" + pass + ";" + "database=" + database + ";";
            MySqlConnection po = new MySqlConnection(logowanie);

            try
            {

                String id = "SELECT DISTINCT ID_zamowienia,Zamowienia_Klienci_ID_klienta, Dania_ID_dania,Nazwa_dania, Zlozono,Wydano FROM restauracja.zamowienia, restauracja.zamowienia_has_dania,restauracja.dania where Dania_ID_dania=ID_dania order by ID_zamowienia;";

                MySqlCommand komendy = new MySqlCommand(id, po);

                po.Open();
                MySqlDataReader dr = komendy.ExecuteReader();

                while (dr.Read())
                {
                    ListViewItem item = new ListViewItem(dr["ID_zamowienia"].ToString());
                    item.SubItems.Add(dr["Zamowienia_Klienci_ID_klienta"].ToString());
                    item.SubItems.Add(dr["Nazwa_dania"].ToString());
                    item.SubItems.Add("nie");
                    listView1.Items.Add(item);
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                if (po.State == System.Data.ConnectionState.Open)
                {
                    po.Close();
                }
            }

        }

        // przycisk ADMIN
        private void button2_Click(object sender, EventArgs e)
        {
            panelLogowanie.Visible = true;
            panelLogowanie.BringToFront();
            panelWybor.Visible = false;
            panelWybor.SendToBack();
        }

        /*****************************************************/
        // panel OBSŁUGI
        /*****************************************************/
        // przycisk zrobione
        private void button6_Click(object sender, EventArgs e)
        {
            DateTime thisDay = DateTime.Now; // Or whatever
            string s = thisDay.ToString("yyyyMMddHHmmss");

            string logowanie = "server=" + serwer + ";" + "uid=" + user + ";" +
                 "pwd=" + pass + ";" + "database=" + database + ";";
            MySqlConnection po = new MySqlConnection(logowanie);


            try
            {
                String id = "UPDATE restauracja.zamowienia set Wydano='" + thisDay + "' where ID_zamowienia='" + textBox1.Text + "';";
                MySqlCommand komendy = new MySqlCommand(id, po);

                po.Open();
                MySqlDataReader dr;

                foreach (ListViewItem i in listView1.Items)
                {
                    if (i.SubItems.Count > 3) //Continue if i.SubItems.Count is more than 3 (The array contains i.SubItems[3] which refers to an item within the 4th column (i.SubItems.Count is not an array. Therefore, it'll start with 1 instead of 0))
                    {
                        if (i.SubItems[0].Text == textBox1.Text.ToString())
                            if (i.SubItems[3].Text == "nie") //Continue if i.SubItems[3].Text is equal to  
                            {
                                dr = komendy.ExecuteReader();
                                i.ForeColor = System.Drawing.Color.Red;
                                i.SubItems[3].Text = i.SubItems[3].Text.Replace("nie", "tak");
                            }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                if (po.State == System.Data.ConnectionState.Open)
                {
                    po.Close();
                }
            }
        }
        // powrót z ekranu obsługi
        private void label1_Click(object sender, EventArgs e)
        {
            panelWybor.Visible = true;
            panelWybor.BringToFront();
            panelObsluga.Visible = false;
            panelObsluga.SendToBack();
        }
        /*****************************************************/
        // panel LOGOWANIA
        /*****************************************************/
        // powrót z ekranu logowania
        private void label4_Click(object sender, EventArgs e)
        {
            panelWybor.Visible = true;
            panelWybor.BringToFront();
            panelObsluga.Visible = false;
            panelObsluga.SendToBack();
        }
        // przycisk "wyczyść"
        private void button4_Click(object sender, EventArgs e)
        {
            loginBox.Text = "";
            passBox.Text = "";
        }
        // przycisk "zatwierdź"
        private void button5_Click(object sender, EventArgs e)
        {
            String login = "admin";
            String password = "admin";

            if (loginBox.Text.ToString() == login && passBox.Text.ToString() == password)
            {
                panelLogowanie.Visible = false;
                panelLogowanie.SendToBack();
                panelAdmin.Visible = true;
                panelAdmin.BringToFront();
                panelAdmin.Enabled = true;
            }
            else
            {
                MessageBox.Show("Niepoprawny login lub hasło!");
            }
        }
        // zatwierdź enterem
        private void passBox_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                button5.PerformClick();
            }
        }
        /*****************************************************/
        // panel ADMINA
        /*****************************************************/
        // wyloguj
        private void button14_Click(object sender, EventArgs e)
        {
            panelWybor.Visible = true;
            panelWybor.BringToFront();
            panelAdmin.Visible = false;
            panelAdmin.SendToBack();
            panelAdmin.Enabled = false;
            loginBox.Text = "";
            passBox.Text = "";
        }

        // dodaj -> pokaż
        private void button15_Click(object sender, EventArgs e)
        {
            listView5.Items.Clear();
            string logowanie = "server=" + serwer + ";" + "uid=" + user + ";" +
                 "pwd=" + pass + ";" + "database=" + database + ";";
            MySqlConnection po = new MySqlConnection(logowanie);

            try
            {

                String id = "SELECT ID_dania, Nazwa_dania, Cena, Ilosc_kalorii FROM restauracja.dania; ";

                MySqlCommand komendy = new MySqlCommand(id, po);

                po.Open();
                MySqlDataReader dr = komendy.ExecuteReader();

                while (dr.Read())
                {
                    ListViewItem item = new ListViewItem(dr["ID_dania"].ToString());
                    item.SubItems.Add(dr["Nazwa_dania"].ToString());
                    item.SubItems.Add(dr["Cena"].ToString());
                    item.SubItems.Add(dr["Ilosc_kalorii"].ToString());
                    listView5.Items.Add(item);
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                if (po.State == System.Data.ConnectionState.Open)
                {
                    po.Close();
                }
            }
        }
        // dodaj -> wstaw
        private void button17_Click(object sender, EventArgs e)
        {

            string logowanie = "server=" + serwer + ";" + "uid=" + user + ";" +
                 "pwd=" + pass + ";" + "database=" + database + ";";
            MySqlConnection po = new MySqlConnection(logowanie);

            try
            {
                String id = "INSERT INTO `restauracja`.`dania` (`ID_dania`, `Typy dan_ID_Typu_dania`, `Ilosc_kalorii`, `Cena`, `Czas_oczekiwania`, `Nazwa_dania`) VALUES ('" + textBoxIDD.Text + "', '" + textBoxTypD.Text + "', '" + textBoxKcalD.Text + "', '" + textBoxIDD.Text + "', '" + textBoxTypD.Text + "', '" + textBoxNazwaD.Text + "');";
                MySqlCommand komendy = new MySqlCommand(id, po);
                MySqlDataReader dr;
                po.Open();
                dr = komendy.ExecuteReader();
                
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                if (po.State == System.Data.ConnectionState.Open)
                {
                    po.Close();
                }
            }
        }
        // dodaj -> wyczyść
        private void button16_Click(object sender, EventArgs e)
        {
            textBoxIDD.Text = "";
            textBoxTypD.Text = "";
            textBoxKcalD.Text = "";
            textBoxCenaD.Text = "";
            textBoxCzasD.Text = "";
            textBoxNazwaD.Text = "";
        }
        
        // usuń -> wyczyść
        private void button22_Click(object sender, EventArgs e)
        {
            textBoxID2.Text = "";
        }
        // usuń -> pokaż
        private void button21_Click(object sender, EventArgs e)
        {
            listView7.Items.Clear();
            string logowanie = "server=" + serwer + ";" + "uid=" + user + ";" +
                 "pwd=" + pass + ";" + "database=" + database + ";";
            MySqlConnection po = new MySqlConnection(logowanie);

            try
            {

                String id = "SELECT ID_dania,`Typy dan_ID_Typu_dania`, Ilosc_kalorii,Cena, Czas_oczekiwania,Nazwa_dania FROM restauracja.dania; ";

                MySqlCommand komendy = new MySqlCommand(id, po);

                po.Open();
                MySqlDataReader dr = komendy.ExecuteReader();

                while (dr.Read())
                {
                    ListViewItem item = new ListViewItem(dr["ID_dania"].ToString());
                    item.SubItems.Add(dr["Typy dan_ID_Typu_dania"].ToString());
                    item.SubItems.Add(dr["Ilosc_kalorii"].ToString());
                    item.SubItems.Add(dr["Cena"].ToString());
                    item.SubItems.Add(dr["Czas_oczekiwania"].ToString());
                    item.SubItems.Add(dr["Nazwa_dania"].ToString());
                    listView7.Items.Add(item);
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                if (po.State == System.Data.ConnectionState.Open)
                {
                    po.Close();
                }
            }
        }
        // usuń -> usuń
        private void button23_Click(object sender, EventArgs e)
        {
            string logowanie = "server=" + serwer + ";" + "uid=" + user + ";" +
                 "pwd=" + pass + ";" + "database=" + database + ";";
            MySqlConnection po = new MySqlConnection(logowanie);

            try
            {

                String id = "delete from restauracja.dania WHERE ID_dania ='" + textBoxID2.Text.ToString() + "';";

                MySqlCommand komendy = new MySqlCommand(id, po);

                po.Open();
                MySqlDataReader dr = komendy.ExecuteReader();

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                if (po.State == System.Data.ConnectionState.Open)
                {
                    po.Close();
                }
            }
        }


        // edytuj -> wyczyść
        private void button19_Click(object sender, EventArgs e)
        {
            textBoxIDE.Text = "";
            textBoxTypE.Text = "";
            textBoxKcalE.Text = "";
            textBoxCenaE.Text = "";
            textBoxCzasE.Text = "";
            textBoxNazwaE.Text = "";
        }
        // edytuj -> pokaż
        private void button18_Click(object sender, EventArgs e)
        {
            listView6.Items.Clear();
            string logowanie = "server=" + serwer + ";" + "uid=" + user + ";" +
                 "pwd=" + pass + ";" + "database=" + database + ";";
            MySqlConnection po = new MySqlConnection(logowanie);

            try
            {

                String id = "SELECT ID_dania,`Typy dan_ID_Typu_dania`, Ilosc_kalorii,Cena, Czas_oczekiwania,Nazwa_dania FROM restauracja.dania; ";

                MySqlCommand komendy = new MySqlCommand(id, po);

                po.Open();
                MySqlDataReader dr = komendy.ExecuteReader();

                while (dr.Read())
                {
                    ListViewItem item = new ListViewItem(dr["ID_dania"].ToString());
                    item.SubItems.Add(dr["Typy dan_ID_Typu_dania"].ToString());
                    item.SubItems.Add(dr["Ilosc_kalorii"].ToString());
                    item.SubItems.Add(dr["Cena"].ToString());
                    item.SubItems.Add(dr["Czas_oczekiwania"].ToString());
                    item.SubItems.Add(dr["Nazwa_dania"].ToString());
                    listView6.Items.Add(item);
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                if (po.State == System.Data.ConnectionState.Open)
                {
                    po.Close();
                }
            }
        }
        // edytuj -> edytuj
        private void button20_Click(object sender, EventArgs e)
        {
            string logowanie = "server=" + serwer + ";" + "uid=" + user + ";" +
                 "pwd=" + pass + ";" + "database=" + database + ";";
            MySqlConnection po = new MySqlConnection(logowanie);

            try
            {
                String id = "UPDATE restauracja.dania SET `Cena`='" + textBoxCenaE.Text + "',`Typy dan_ID_Typu_dania`='" + textBoxTypD.Text + "',`Ilosc_kalorii`='" + textBoxKcalD.Text + "',`Czas_oczekiwania`='" + textBoxCzasE.Text + "',`Nazwa_dania`='" + textBoxNazwaD.Text + "'  WHERE `ID_dania`='" + textBoxIDD.Text + "';";
                MySqlCommand komendy = new MySqlCommand(id, po);
                MySqlDataReader dr;
                po.Open();
                dr = komendy.ExecuteReader();

                //dodanie do bazy
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                if (po.State == System.Data.ConnectionState.Open)
                {
                    po.Close();
                }
            }
        }

        // rekordy przycisk odśwież
        private void button3_Click(object sender, EventArgs e)
        {

            string logowanie = "server=" + serwer + ";" + "uid=" + user + ";" +
                    "pwd=" + pass + ";" + "database=" + database + ";";
            // bestsellery
            listView4.Items.Clear();
            try
            {
                string Query = "SELECT count(Nazwa_dania), Nazwa_dania,  ID_dania, Cena FROM restauracja.dania JOIN `restauracja`.`zamowienia_has_dania` ON Dania_ID_Dania = ID_Dania group by Nazwa_dania order by count(Nazwa_dania) desc";

                MySqlConnection MyConn2 = new MySqlConnection(logowanie);
                MySqlCommand MyCommand2 = new MySqlCommand(Query, MyConn2);

                MyConn2.Open();
                MySqlDataAdapter MyAdapter = new MySqlDataAdapter();
                MyAdapter.SelectCommand = MyCommand2;

                DataSet ds = new DataSet();
                MyAdapter.Fill(ds);

                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    ListViewItem item = new ListViewItem(dr["count(Nazwa_dania)"].ToString());
                    item.SubItems.Add(dr["Nazwa_dania"].ToString());
                    item.SubItems.Add(dr["ID_dania"].ToString());
                    item.SubItems.Add(dr["Cena"].ToString());

                    listView4.Items.Add(item);
                }

                MyConn2.Close();


            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
