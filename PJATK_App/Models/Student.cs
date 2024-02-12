using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace PJATK_App.Models
{
    internal class Student
    {	
		//Backing field
		private int _idStudent;

		//Property
		public int IdStudent
		{
			get { return _idStudent; }
			set 
			{ 
				//validation rule
				if (value <= 0)
				{
					throw new ArgumentOutOfRangeException("IdStudent", "IdStudent must be greater than zero.");	
				}
				_idStudent = value; 
			}
		}

		private string _firstName;

		public string FirstName
		{
			get { return _firstName; }
			set 
			{ 
				if (string.IsNullOrWhiteSpace(value)) 
				{ 
					throw new ArgumentOutOfRangeException("FirstName", "FirstName cannot be empty.");
				}
				_firstName = value; 
			}
		}

		private string _lastName;

		public string LastName
		{
			get { return _lastName; }
			set 
			{ 
				if (string.IsNullOrWhiteSpace(value)) 
				{ 
					throw new ArgumentOutOfRangeException("LastName", "LastName cannot be empty.");
				}

				_lastName = value; 
			}
		}

		private string _email;

		public string Email
		{
			get { return _email; }
			set 
			{
                if (string.IsNullOrWhiteSpace(value))
                {
                    throw new ArgumentOutOfRangeException("Email", "Email cannot be empty.");
                }

				Regex regex = new Regex(@"[a-zA-Z]+@[a-zA-Z]+.[a-zA-Z]+");
				if (!regex.IsMatch(value)) 
				{
                    throw new ArgumentOutOfRangeException("Email", "Email is not valid.");
                }
				
				
				_email = value; 
			}
		}

		private string _indexNumber;

		public string IndexNumber
		{
			get { return _indexNumber; }
			set 
			{ 
				if (string.IsNullOrWhiteSpace(value))
				{
                    throw new ArgumentOutOfRangeException("IndexNumber", "IndexNumber cannot be empty.");
                }

                Regex regex = new Regex(@"s[0-9]+");
                if (!regex.IsMatch(value))
                {
                    throw new ArgumentOutOfRangeException("IndexNumber", "IndexNumber is not valid.");
                }

                _indexNumber = value; 
			}
		}

		private string _address;

		public string Address
		{
			get { return _address; }
			set 
			{
                if (string.IsNullOrWhiteSpace(value))
                {
                    throw new ArgumentOutOfRangeException("Address", "Address cannot be empty.");
                }
                _address = value; 
			}
		}

		public Student(string firstName, string lastName, string indexNumber)
		{
			this.FirstName = firstName;
			this.LastName = lastName;
			this.IndexNumber = indexNumber;
		}
	}
}
