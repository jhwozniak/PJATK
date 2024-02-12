namespace PJATK_App
{
    partial class MainWindow
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            menuStrip1 = new MenuStrip();
            plikToolStripMenuItem = new ToolStripMenuItem();
            zamknijToolStripMenuItem = new ToolStripMenuItem();
            label1 = new Label();
            studentsDataGridView = new DataGridView();
            panel1 = new Panel();
            deleteStudentButton = new Button();
            editStudentButton = new Button();
            addStudentButton = new Button();
            menuStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)studentsDataGridView).BeginInit();
            panel1.SuspendLayout();
            SuspendLayout();
            // 
            // menuStrip1
            // 
            menuStrip1.ImageScalingSize = new Size(20, 20);
            menuStrip1.Items.AddRange(new ToolStripItem[] { plikToolStripMenuItem });
            menuStrip1.Location = new Point(0, 0);
            menuStrip1.Name = "menuStrip1";
            menuStrip1.Size = new Size(800, 28);
            menuStrip1.TabIndex = 0;
            menuStrip1.Text = "menuStrip1";
            // 
            // plikToolStripMenuItem
            // 
            plikToolStripMenuItem.DropDownItems.AddRange(new ToolStripItem[] { zamknijToolStripMenuItem });
            plikToolStripMenuItem.Font = new Font("Cascadia Code", 9F, FontStyle.Regular, GraphicsUnit.Point);
            plikToolStripMenuItem.Name = "plikToolStripMenuItem";
            plikToolStripMenuItem.Size = new Size(59, 24);
            plikToolStripMenuItem.Text = "Plik";
            // 
            // zamknijToolStripMenuItem
            // 
            zamknijToolStripMenuItem.Name = "zamknijToolStripMenuItem";
            zamknijToolStripMenuItem.Size = new Size(155, 26);
            zamknijToolStripMenuItem.Text = "Zamknij";
            zamknijToolStripMenuItem.Click += zamknijToolStripMenuItem_Click;
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Font = new Font("Cascadia Code", 18F, FontStyle.Regular, GraphicsUnit.Point);
            label1.Location = new Point(12, 9);
            label1.Name = "label1";
            label1.Size = new Size(287, 40);
            label1.TabIndex = 1;
            label1.Text = "Lista studentów";
            // 
            // studentsDataGridView
            // 
            studentsDataGridView.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            studentsDataGridView.Dock = DockStyle.Fill;
            studentsDataGridView.Location = new Point(0, 143);
            studentsDataGridView.Name = "studentsDataGridView";
            studentsDataGridView.RowHeadersWidth = 51;
            studentsDataGridView.RowTemplate.Height = 29;
            studentsDataGridView.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            studentsDataGridView.Size = new Size(800, 307);
            studentsDataGridView.TabIndex = 2;
            studentsDataGridView.CellContentClick += studentsDataGridView_CellContentClick;
            // 
            // panel1
            // 
            panel1.Controls.Add(deleteStudentButton);
            panel1.Controls.Add(editStudentButton);
            panel1.Controls.Add(addStudentButton);
            panel1.Controls.Add(label1);
            panel1.Dock = DockStyle.Top;
            panel1.Location = new Point(0, 28);
            panel1.Name = "panel1";
            panel1.Size = new Size(800, 115);
            panel1.TabIndex = 3;
            // 
            // deleteStudentButton
            // 
            deleteStudentButton.Font = new Font("Cascadia Code", 9F, FontStyle.Regular, GraphicsUnit.Point);
            deleteStudentButton.Location = new Point(533, 65);
            deleteStudentButton.Name = "deleteStudentButton";
            deleteStudentButton.Size = new Size(236, 29);
            deleteStudentButton.TabIndex = 4;
            deleteStudentButton.Text = "Usuń studenta";
            deleteStudentButton.UseVisualStyleBackColor = true;
            deleteStudentButton.Click += deleteStudentButton_Click;
            // 
            // editStudentButton
            // 
            editStudentButton.Font = new Font("Cascadia Code", 9F, FontStyle.Regular, GraphicsUnit.Point);
            editStudentButton.Location = new Point(279, 65);
            editStudentButton.Name = "editStudentButton";
            editStudentButton.Size = new Size(236, 29);
            editStudentButton.TabIndex = 3;
            editStudentButton.Text = "Edytuj studenta";
            editStudentButton.UseVisualStyleBackColor = true;
            editStudentButton.Click += editStudentButton_Click;
            // 
            // addStudentButton
            // 
            addStudentButton.Font = new Font("Cascadia Code", 9F, FontStyle.Regular, GraphicsUnit.Point);
            addStudentButton.Location = new Point(22, 65);
            addStudentButton.Name = "addStudentButton";
            addStudentButton.Size = new Size(236, 29);
            addStudentButton.TabIndex = 2;
            addStudentButton.Text = "Dodaj studenta";
            addStudentButton.UseVisualStyleBackColor = true;
            addStudentButton.Click += addStudentButton_Click;
            // 
            // MainWindow
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(studentsDataGridView);
            Controls.Add(panel1);
            Controls.Add(menuStrip1);
            MainMenuStrip = menuStrip1;
            Name = "MainWindow";
            StartPosition = FormStartPosition.CenterScreen;
            Text = "Okno główne";
            menuStrip1.ResumeLayout(false);
            menuStrip1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)studentsDataGridView).EndInit();
            panel1.ResumeLayout(false);
            panel1.PerformLayout();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private MenuStrip menuStrip1;
        private ToolStripMenuItem plikToolStripMenuItem;
        private ToolStripMenuItem zamknijToolStripMenuItem;
        private Label label1;
        private DataGridView studentsDataGridView;
        private Panel panel1;
        private Button addStudentButton;
        private Button deleteStudentButton;
        private Button editStudentButton;
    }
}