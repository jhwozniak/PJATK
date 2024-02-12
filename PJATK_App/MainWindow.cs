using PJATK_App.Models;
using System.Data.SqlClient;

namespace PJATK_App
{
    public partial class MainWindow : Form
    {
        public const string ConnectionString = "Data Source=db-mssql.pjwstk.edu.pl;Initial Catalog=2019SBD;Integrated Security=True;TrustServerCertificate=True;";
        public MainWindow()
        {
            InitializeComponent();
            ZaladujDane(); //Tutaj za³adujemy dane z bazy
        }

        private void ZaladujDane()
        {
            var con = new SqlConnection(ConnectionString);
            var com = new SqlCommand();

            try
            {
                com.Connection = con;
                com.CommandText = "SELECT * FROM Student ORDER BY lastName";

                var studenci = new List<Student>();
                con.Open();
                var dr = com.ExecuteReader();

                while (dr.Read())
                {
                    var nowyStudent = new Student(
                        dr["FirstName"].ToString(),
                        dr["LastName"].ToString(),
                        dr["IndexNumber"].ToString()
                        );

                    nowyStudent.Email = dr["Email"].ToString();
                    nowyStudent.IdStudent = (int)dr["IdStudent"];
                    nowyStudent.Address = dr["Address"].ToString();

                    studenci.Add(nowyStudent);
                }
                con.Close();

                studentsDataGridView.DataSource = studenci;
            }
            catch
            {
                MessageBox.Show("Pojawil sie blad podczas wstawiania danych.");
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void plikToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void zamknijToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void deleteStudentButton_Click(object sender, EventArgs e)
        {
            var con = new SqlConnection(ConnectionString);
            var com = new SqlCommand();

            if (studentsDataGridView.SelectedRows.Count == 0)
            {
                MessageBox.Show("Nie wybrales studenta do usuniecia.");
                return;
            }

            var studentDoUsuniecia = studentsDataGridView.SelectedRows[0].DataBoundItem as Student;
            com.Connection = con;
            com.CommandText = "DELETE FROM Student WHERE IdStudent=@IdStudent";
            com.Parameters.AddWithValue("@IdStudent", studentDoUsuniecia.IdStudent);

            con.Open();
            com.ExecuteNonQuery();
            con.Close();
            ZaladujDane();//odœwie¿amy dane w interfejsie
        }

        private void addStudentButton_Click(object sender, EventArgs e)
        {
            var okienko = new StudentDetails().ShowDialog();
            ZaladujDane();
        }

        private void studentsDataGridView_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void editStudentButton_Click(object sender, EventArgs e)
        {
            if (studentsDataGridView.SelectedRows.Count == 0)
            {
                MessageBox.Show("Nie wybrales studenta do modyfikacji.");
                return;
            }

            var studentDoModyfikacji = studentsDataGridView.SelectedRows[0].DataBoundItem as Student;
            var okienko = new StudentDetails(studentDoModyfikacji).ShowDialog();
            ZaladujDane();

        }
    }
}