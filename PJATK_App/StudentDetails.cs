using PJATK_App.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PJATK_App
{
    public partial class StudentDetails : Form
    {
        internal Student studentDoModyfikacji;
        
        public StudentDetails()
        {
            InitializeComponent();
        }

        internal StudentDetails(Student? studentDoModyfikacji)
        {
            this.studentDoModyfikacji = studentDoModyfikacji;
            InitializeComponent();
            ZaladujDoFormularza(studentDoModyfikacji);//ładuje dane wybranego studenta z pamięci do formularza            
        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void closeButton_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void okButton_Click(object sender, EventArgs e) //jeśli studentDoModyfikacji null - insert, jeśli nie - update
        {
            string imie = imieTextBox.Text;
            string nazwisko = nazwiskoTextBox.Text;
            string adres = adresTextBox.Text;
            string email = emailTextBox.Text;
            string nrIndeksu = numerIndeksuTextBox.Text;

            if (string.IsNullOrWhiteSpace(imie) || string.IsNullOrWhiteSpace(nazwisko) || string.IsNullOrWhiteSpace(email) ||
                    string.IsNullOrWhiteSpace(adres) || string.IsNullOrWhiteSpace(nrIndeksu))
            {
                MessageBox.Show("Wszystkie pola musza byc wypelnione");
                return;
            }

            //jeśli nie istnieje obiekt studentDoModyfikacji (nie wciśnięto "Edytuj studenta")
            if(this.studentDoModyfikacji == null)
            {                
                var nowyStudent = new Student(imie, nazwisko, nrIndeksu);
                nowyStudent.Address = adres;
                nowyStudent.Email = email;
                ZapiszStudenta(nowyStudent);
                Close();
            }
            //jeśli istnieje obiekt studentDoModyfikacji (wciśnięto "Edytuj studenta")
            else if (this.studentDoModyfikacji != null)
            {
                ModyfikujStudenta(studentDoModyfikacji);
                Close();
            }
                       
        }

        private void ZapiszStudenta(Student st)
        {
            var con = new SqlConnection(MainWindow.ConnectionString);
            var com = new SqlCommand();

            com.Connection = con;
            com.CommandText = "INSERT INTO Student(FirstName, LastName, IndexNumber, Email, Address) VALUES(@FirstName, @LastName, @IndexNumber, @Email, @Address)";
            com.Parameters.AddWithValue("@FirstName", st.FirstName);
            com.Parameters.AddWithValue("@LastName", st.LastName);
            com.Parameters.AddWithValue("@IndexNumber", st.IndexNumber);
            com.Parameters.AddWithValue("@Email", st.Email);
            com.Parameters.AddWithValue("@Address", st.Address);

            con.Open();
            com.ExecuteNonQuery();
            con.Close();

        }
                
        private void ZaladujDoFormularza(Student st)
        {
            imieTextBox.Text = st.FirstName;
            nazwiskoTextBox.Text = st.LastName;
            adresTextBox.Text = st.Address;
            emailTextBox.Text = st.Email;
            numerIndeksuTextBox.Text = st.IndexNumber;       
        }
                
        private void ModyfikujStudenta(Student st)
        {
            //spr czy wszystkie pola pełne
            string imie = imieTextBox.Text;
            string nazwisko = nazwiskoTextBox.Text;
            string adres = adresTextBox.Text;
            string email = emailTextBox.Text;
            string nrIndeksu = numerIndeksuTextBox.Text;

            if (string.IsNullOrWhiteSpace(imie) || string.IsNullOrWhiteSpace(nazwisko) || string.IsNullOrWhiteSpace(email) ||
                    string.IsNullOrWhiteSpace(adres) || string.IsNullOrWhiteSpace(nrIndeksu))
            {
                MessageBox.Show("Wszystkie pola musza byc wypelnione");
                return;
            }

            //połącz z bazą danych
            var con = new SqlConnection(MainWindow.ConnectionString);
            var com = new SqlCommand();
            com.Connection = con;

            //update
            com.CommandText = "UPDATE Student SET FirstName = @FirstName, LastName = @LastName, IndexNumber = @IndexNumber, Email = @Email, Address = @Address WHERE IdStudent=@IdStudent";
            com.Parameters.AddWithValue("@IdStudent", studentDoModyfikacji.IdStudent);
            com.Parameters.AddWithValue("@FirstName", imie);
            com.Parameters.AddWithValue("@LastName", nazwisko);
            com.Parameters.AddWithValue("@IndexNumber", nrIndeksu);
            com.Parameters.AddWithValue("@Email", email);
            com.Parameters.AddWithValue("@Address", adres);

            con.Open();
            com.ExecuteNonQuery();
            con.Close();
            
            //ustaw wskaźnik do obiektu na nulla, żeby można było dodawać kolejnych studentów
            studentDoModyfikacji = null;            
        }

        private void StudentDetails_Load(object sender, EventArgs e)
        {

        }


    }

        
    
}
