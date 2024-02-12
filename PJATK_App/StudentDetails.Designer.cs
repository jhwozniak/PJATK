namespace PJATK_App
{
    partial class StudentDetails
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
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
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            label1 = new Label();
            label2 = new Label();
            label3 = new Label();
            label4 = new Label();
            label5 = new Label();
            label6 = new Label();
            okButton = new Button();
            closeButton = new Button();
            imieTextBox = new TextBox();
            nazwiskoTextBox = new TextBox();
            emailTextBox = new TextBox();
            numerIndeksuTextBox = new TextBox();
            adresTextBox = new TextBox();
            SuspendLayout();
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Font = new Font("Cascadia Code", 9F, FontStyle.Regular, GraphicsUnit.Point);
            label1.Location = new Point(29, 21);
            label1.Name = "label1";
            label1.Size = new Size(135, 20);
            label1.TabIndex = 0;
            label1.Text = "Dane studenta:";
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Font = new Font("Cascadia Code", 9F, FontStyle.Regular, GraphicsUnit.Point);
            label2.Location = new Point(110, 69);
            label2.Name = "label2";
            label2.Size = new Size(54, 20);
            label2.TabIndex = 1;
            label2.Text = "Imie:";
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Font = new Font("Cascadia Code", 9F, FontStyle.Regular, GraphicsUnit.Point);
            label3.Location = new Point(76, 107);
            label3.Name = "label3";
            label3.Size = new Size(90, 20);
            label3.TabIndex = 2;
            label3.Text = "Nazwisko:";
            // 
            // label4
            // 
            label4.AutoSize = true;
            label4.Font = new Font("Cascadia Code", 9F, FontStyle.Regular, GraphicsUnit.Point);
            label4.Location = new Point(102, 152);
            label4.Name = "label4";
            label4.Size = new Size(63, 20);
            label4.TabIndex = 3;
            label4.Text = "Email:";
            label4.Click += label4_Click;
            // 
            // label5
            // 
            label5.AutoSize = true;
            label5.Font = new Font("Cascadia Code", 9F, FontStyle.Regular, GraphicsUnit.Point);
            label5.Location = new Point(40, 196);
            label5.Name = "label5";
            label5.Size = new Size(135, 20);
            label5.TabIndex = 4;
            label5.Text = "Numer indeksu:";
            // 
            // label6
            // 
            label6.AutoSize = true;
            label6.Font = new Font("Cascadia Code", 9F, FontStyle.Regular, GraphicsUnit.Point);
            label6.Location = new Point(101, 240);
            label6.Name = "label6";
            label6.Size = new Size(63, 20);
            label6.TabIndex = 5;
            label6.Text = "Adres:";
            // 
            // okButton
            // 
            okButton.Font = new Font("Cascadia Code", 9F, FontStyle.Regular, GraphicsUnit.Point);
            okButton.Location = new Point(76, 298);
            okButton.Name = "okButton";
            okButton.Size = new Size(187, 67);
            okButton.TabIndex = 6;
            okButton.Text = "Zapisz";
            okButton.UseVisualStyleBackColor = true;
            okButton.Click += okButton_Click;
            // 
            // closeButton
            // 
            closeButton.Font = new Font("Cascadia Code", 9F, FontStyle.Regular, GraphicsUnit.Point);
            closeButton.Location = new Point(324, 298);
            closeButton.Name = "closeButton";
            closeButton.Size = new Size(182, 67);
            closeButton.TabIndex = 7;
            closeButton.Text = "Zamknij";
            closeButton.UseVisualStyleBackColor = true;
            closeButton.Click += closeButton_Click;
            // 
            // imieTextBox
            // 
            imieTextBox.Location = new Point(182, 66);
            imieTextBox.Name = "imieTextBox";
            imieTextBox.Size = new Size(324, 27);
            imieTextBox.TabIndex = 8;
            // 
            // nazwiskoTextBox
            // 
            nazwiskoTextBox.Location = new Point(182, 104);
            nazwiskoTextBox.Name = "nazwiskoTextBox";
            nazwiskoTextBox.Size = new Size(324, 27);
            nazwiskoTextBox.TabIndex = 9;
            // 
            // emailTextBox
            // 
            emailTextBox.Location = new Point(182, 145);
            emailTextBox.Name = "emailTextBox";
            emailTextBox.Size = new Size(324, 27);
            emailTextBox.TabIndex = 10;
            // 
            // numerIndeksuTextBox
            // 
            numerIndeksuTextBox.Location = new Point(182, 189);
            numerIndeksuTextBox.Name = "numerIndeksuTextBox";
            numerIndeksuTextBox.Size = new Size(324, 27);
            numerIndeksuTextBox.TabIndex = 11;
            // 
            // adresTextBox
            // 
            adresTextBox.Location = new Point(182, 233);
            adresTextBox.Name = "adresTextBox";
            adresTextBox.Size = new Size(324, 27);
            adresTextBox.TabIndex = 12;
            // 
            // StudentDetails
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(550, 394);
            Controls.Add(adresTextBox);
            Controls.Add(numerIndeksuTextBox);
            Controls.Add(emailTextBox);
            Controls.Add(nazwiskoTextBox);
            Controls.Add(imieTextBox);
            Controls.Add(closeButton);
            Controls.Add(okButton);
            Controls.Add(label6);
            Controls.Add(label5);
            Controls.Add(label4);
            Controls.Add(label3);
            Controls.Add(label2);
            Controls.Add(label1);
            FormBorderStyle = FormBorderStyle.FixedToolWindow;
            Name = "StudentDetails";
            StartPosition = FormStartPosition.CenterParent;
            Text = "Dane studenta";
            Load += StudentDetails_Load;
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private Label label1;
        private Label label2;
        private Label label3;
        private Label label4;
        private Label label5;
        private Label label6;
        private Button okButton;
        private Button closeButton;
        private TextBox imieTextBox;
        private TextBox nazwiskoTextBox;
        private TextBox emailTextBox;
        private TextBox numerIndeksuTextBox;
        private TextBox adresTextBox;
    }
}