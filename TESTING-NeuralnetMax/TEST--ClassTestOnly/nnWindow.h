#pragma once
#include "stdafx.h"

namespace TESTClassTestOnly {

	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;

	/// <summary>
	/// Summary for nnWindow
	/// </summary>
	public ref class nnWindow : public System::Windows::Forms::Form
	{
	public:
		nnWindow(void)
		{
			InitializeComponent();
			//
			//TODO: Add the constructor code here
			//
		}

	protected:
		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		~nnWindow()
		{
			if (components)
			{
				delete components;
			}
		}
	private: System::Windows::Forms::Button^  button5;
	protected:
	private: System::Windows::Forms::Button^  button4;
	private: System::Windows::Forms::Button^  button3;
	private: System::Windows::Forms::GroupBox^  groupBox3;
	private: System::Windows::Forms::Label^  label10;
	private: System::Windows::Forms::Label^  label12;
	private: System::Windows::Forms::Label^  label14;

	private: System::Windows::Forms::Label^  label17;



	private: System::Windows::Forms::Label^  label20;

	private: System::Windows::Forms::GroupBox^  groupBox2;
	private: System::Windows::Forms::Label^  label1;
	private: System::Windows::Forms::Label^  label5;
	private: System::Windows::Forms::Label^  label4;

	private: System::Windows::Forms::Label^  label2;



	private: System::Windows::Forms::Label^  label3;

	private: System::Windows::Forms::GroupBox^  groupBox1;
	private: System::Windows::Forms::Label^  label11;

	private: System::Windows::Forms::Label^  label15;

	private: System::Windows::Forms::Label^  label13;

	private: System::Windows::Forms::Label^  label9;

	private: System::Windows::Forms::Button^  button2;
	private: System::Windows::Forms::Button^  button1;
	private: System::Windows::Forms::Label^  label6;
	private: System::Windows::Forms::Label^  label7;
	private: System::Windows::Forms::Label^  label8;
	private: System::Windows::Forms::Label^  label16;
	private: System::Windows::Forms::Label^  label18;
	private: System::Windows::Forms::Label^  label19;
	private: System::Windows::Forms::Label^  label21;
	private: System::Windows::Forms::Label^  label22;
	private: System::Windows::Forms::Label^  label23;
	private: System::Windows::Forms::Label^  label24;
	private: System::Windows::Forms::Label^  label25;
	private: System::Windows::Forms::Label^  label26;
	private: System::Windows::Forms::Label^  label27;
	private: System::Windows::Forms::Label^  label28;

	private:
		/// <summary>
		/// Required designer variable.
		/// </summary>
		System::ComponentModel::Container ^components;

#pragma region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		void InitializeComponent(void)
		{
			this->button5 = (gcnew System::Windows::Forms::Button());
			this->button4 = (gcnew System::Windows::Forms::Button());
			this->button3 = (gcnew System::Windows::Forms::Button());
			this->groupBox3 = (gcnew System::Windows::Forms::GroupBox());
			this->label19 = (gcnew System::Windows::Forms::Label());
			this->label21 = (gcnew System::Windows::Forms::Label());
			this->label22 = (gcnew System::Windows::Forms::Label());
			this->label23 = (gcnew System::Windows::Forms::Label());
			this->label24 = (gcnew System::Windows::Forms::Label());
			this->label10 = (gcnew System::Windows::Forms::Label());
			this->label12 = (gcnew System::Windows::Forms::Label());
			this->label14 = (gcnew System::Windows::Forms::Label());
			this->label17 = (gcnew System::Windows::Forms::Label());
			this->label20 = (gcnew System::Windows::Forms::Label());
			this->groupBox2 = (gcnew System::Windows::Forms::GroupBox());
			this->label6 = (gcnew System::Windows::Forms::Label());
			this->label7 = (gcnew System::Windows::Forms::Label());
			this->label8 = (gcnew System::Windows::Forms::Label());
			this->label16 = (gcnew System::Windows::Forms::Label());
			this->label18 = (gcnew System::Windows::Forms::Label());
			this->label1 = (gcnew System::Windows::Forms::Label());
			this->label5 = (gcnew System::Windows::Forms::Label());
			this->label4 = (gcnew System::Windows::Forms::Label());
			this->label2 = (gcnew System::Windows::Forms::Label());
			this->label3 = (gcnew System::Windows::Forms::Label());
			this->groupBox1 = (gcnew System::Windows::Forms::GroupBox());
			this->label25 = (gcnew System::Windows::Forms::Label());
			this->label26 = (gcnew System::Windows::Forms::Label());
			this->label27 = (gcnew System::Windows::Forms::Label());
			this->label28 = (gcnew System::Windows::Forms::Label());
			this->label11 = (gcnew System::Windows::Forms::Label());
			this->label15 = (gcnew System::Windows::Forms::Label());
			this->label13 = (gcnew System::Windows::Forms::Label());
			this->label9 = (gcnew System::Windows::Forms::Label());
			this->button2 = (gcnew System::Windows::Forms::Button());
			this->button1 = (gcnew System::Windows::Forms::Button());
			this->groupBox3->SuspendLayout();
			this->groupBox2->SuspendLayout();
			this->groupBox1->SuspendLayout();
			this->SuspendLayout();
			// 
			// button5
			// 
			this->button5->Location = System::Drawing::Point(12, 86);
			this->button5->Name = L"button5";
			this->button5->Size = System::Drawing::Size(75, 23);
			this->button5->TabIndex = 25;
			this->button5->Text = L"Wind Obj";
			this->button5->UseVisualStyleBackColor = true;
			// 
			// button4
			// 
			this->button4->Location = System::Drawing::Point(12, 54);
			this->button4->Name = L"button4";
			this->button4->Size = System::Drawing::Size(75, 23);
			this->button4->TabIndex = 24;
			this->button4->Text = L"Target Obj";
			this->button4->UseVisualStyleBackColor = true;
			// 
			// button3
			// 
			this->button3->Location = System::Drawing::Point(12, 24);
			this->button3->Name = L"button3";
			this->button3->Size = System::Drawing::Size(75, 23);
			this->button3->TabIndex = 23;
			this->button3->Text = L"Source Obj";
			this->button3->UseVisualStyleBackColor = true;
			// 
			// groupBox3
			// 
			this->groupBox3->Controls->Add(this->label19);
			this->groupBox3->Controls->Add(this->label21);
			this->groupBox3->Controls->Add(this->label22);
			this->groupBox3->Controls->Add(this->label23);
			this->groupBox3->Controls->Add(this->label24);
			this->groupBox3->Controls->Add(this->label10);
			this->groupBox3->Controls->Add(this->label12);
			this->groupBox3->Controls->Add(this->label14);
			this->groupBox3->Controls->Add(this->label17);
			this->groupBox3->Controls->Add(this->label20);
			this->groupBox3->Location = System::Drawing::Point(227, 11);
			this->groupBox3->Name = L"groupBox3";
			this->groupBox3->Size = System::Drawing::Size(142, 163);
			this->groupBox3->TabIndex = 22;
			this->groupBox3->TabStop = false;
			this->groupBox3->Text = L"Current Values:";
			// 
			// label19
			// 
			this->label19->Anchor = System::Windows::Forms::AnchorStyles::Right;
			this->label19->AutoSize = true;
			this->label19->Location = System::Drawing::Point(61, 25);
			this->label19->Name = L"label19";
			this->label19->Size = System::Drawing::Size(22, 13);
			this->label19->TabIndex = 7;
			this->label19->Text = L"0.0";
			// 
			// label21
			// 
			this->label21->Anchor = System::Windows::Forms::AnchorStyles::Right;
			this->label21->AutoSize = true;
			this->label21->Location = System::Drawing::Point(61, 52);
			this->label21->Name = L"label21";
			this->label21->Size = System::Drawing::Size(22, 13);
			this->label21->TabIndex = 11;
			this->label21->Text = L"0.0";
			// 
			// label22
			// 
			this->label22->Anchor = System::Windows::Forms::AnchorStyles::Right;
			this->label22->AutoSize = true;
			this->label22->Location = System::Drawing::Point(61, 136);
			this->label22->Name = L"label22";
			this->label22->Size = System::Drawing::Size(22, 13);
			this->label22->TabIndex = 10;
			this->label22->Text = L"0.0";
			// 
			// label23
			// 
			this->label23->Anchor = System::Windows::Forms::AnchorStyles::Right;
			this->label23->AutoSize = true;
			this->label23->Location = System::Drawing::Point(61, 80);
			this->label23->Name = L"label23";
			this->label23->Size = System::Drawing::Size(22, 13);
			this->label23->TabIndex = 8;
			this->label23->Text = L"0.0";
			// 
			// label24
			// 
			this->label24->Anchor = System::Windows::Forms::AnchorStyles::Right;
			this->label24->AutoSize = true;
			this->label24->Location = System::Drawing::Point(61, 109);
			this->label24->Name = L"label24";
			this->label24->Size = System::Drawing::Size(22, 13);
			this->label24->TabIndex = 9;
			this->label24->Text = L"0.0";
			// 
			// label10
			// 
			this->label10->AutoSize = true;
			this->label10->Location = System::Drawing::Point(6, 25);
			this->label10->Name = L"label10";
			this->label10->Size = System::Drawing::Size(49, 13);
			this->label10->TabIndex = 2;
			this->label10->Text = L"Distance";
			// 
			// label12
			// 
			this->label12->AutoSize = true;
			this->label12->Location = System::Drawing::Point(6, 52);
			this->label12->Name = L"label12";
			this->label12->Size = System::Drawing::Size(57, 13);
			this->label12->TabIndex = 6;
			this->label12->Text = L"Movement";
			// 
			// label14
			// 
			this->label14->AutoSize = true;
			this->label14->Location = System::Drawing::Point(6, 136);
			this->label14->Name = L"label14";
			this->label14->Size = System::Drawing::Size(31, 13);
			this->label14->TabIndex = 5;
			this->label14->Text = L"Tilt Z";
			// 
			// label17
			// 
			this->label17->AutoSize = true;
			this->label17->Location = System::Drawing::Point(6, 80);
			this->label17->Name = L"label17";
			this->label17->Size = System::Drawing::Size(31, 13);
			this->label17->TabIndex = 3;
			this->label17->Text = L"Tilt X";
			// 
			// label20
			// 
			this->label20->AutoSize = true;
			this->label20->Location = System::Drawing::Point(6, 109);
			this->label20->Name = L"label20";
			this->label20->Size = System::Drawing::Size(31, 13);
			this->label20->TabIndex = 4;
			this->label20->Text = L"Tilt Y";
			// 
			// groupBox2
			// 
			this->groupBox2->Controls->Add(this->label6);
			this->groupBox2->Controls->Add(this->label7);
			this->groupBox2->Controls->Add(this->label8);
			this->groupBox2->Controls->Add(this->label16);
			this->groupBox2->Controls->Add(this->label18);
			this->groupBox2->Controls->Add(this->label1);
			this->groupBox2->Controls->Add(this->label5);
			this->groupBox2->Controls->Add(this->label4);
			this->groupBox2->Controls->Add(this->label2);
			this->groupBox2->Controls->Add(this->label3);
			this->groupBox2->Location = System::Drawing::Point(93, 9);
			this->groupBox2->Name = L"groupBox2";
			this->groupBox2->Size = System::Drawing::Size(128, 164);
			this->groupBox2->TabIndex = 21;
			this->groupBox2->TabStop = false;
			this->groupBox2->Text = L"Nodes:";
			// 
			// label6
			// 
			this->label6->Anchor = System::Windows::Forms::AnchorStyles::Right;
			this->label6->AutoSize = true;
			this->label6->Location = System::Drawing::Point(54, 25);
			this->label6->Name = L"label6";
			this->label6->Size = System::Drawing::Size(22, 13);
			this->label6->TabIndex = 7;
			this->label6->Text = L"0.0";
			// 
			// label7
			// 
			this->label7->Anchor = System::Windows::Forms::AnchorStyles::Right;
			this->label7->AutoSize = true;
			this->label7->Location = System::Drawing::Point(54, 137);
			this->label7->Name = L"label7";
			this->label7->Size = System::Drawing::Size(22, 13);
			this->label7->TabIndex = 11;
			this->label7->Text = L"0.0";
			// 
			// label8
			// 
			this->label8->Anchor = System::Windows::Forms::AnchorStyles::Right;
			this->label8->AutoSize = true;
			this->label8->Location = System::Drawing::Point(54, 110);
			this->label8->Name = L"label8";
			this->label8->Size = System::Drawing::Size(22, 13);
			this->label8->TabIndex = 10;
			this->label8->Text = L"0.0";
			// 
			// label16
			// 
			this->label16->Anchor = System::Windows::Forms::AnchorStyles::Right;
			this->label16->AutoSize = true;
			this->label16->Location = System::Drawing::Point(54, 54);
			this->label16->Name = L"label16";
			this->label16->Size = System::Drawing::Size(22, 13);
			this->label16->TabIndex = 8;
			this->label16->Text = L"0.0";
			// 
			// label18
			// 
			this->label18->Anchor = System::Windows::Forms::AnchorStyles::Right;
			this->label18->AutoSize = true;
			this->label18->Location = System::Drawing::Point(54, 83);
			this->label18->Name = L"label18";
			this->label18->Size = System::Drawing::Size(22, 13);
			this->label18->TabIndex = 9;
			this->label18->Text = L"0.0";
			// 
			// label1
			// 
			this->label1->AutoSize = true;
			this->label1->Location = System::Drawing::Point(6, 25);
			this->label1->Name = L"label1";
			this->label1->Size = System::Drawing::Size(42, 13);
			this->label1->TabIndex = 2;
			this->label1->Text = L"Node 1";
			// 
			// label5
			// 
			this->label5->AutoSize = true;
			this->label5->Location = System::Drawing::Point(6, 137);
			this->label5->Name = L"label5";
			this->label5->Size = System::Drawing::Size(42, 13);
			this->label5->TabIndex = 6;
			this->label5->Text = L"Node 5";
			// 
			// label4
			// 
			this->label4->AutoSize = true;
			this->label4->Location = System::Drawing::Point(6, 110);
			this->label4->Name = L"label4";
			this->label4->Size = System::Drawing::Size(42, 13);
			this->label4->TabIndex = 5;
			this->label4->Text = L"Node 4";
			// 
			// label2
			// 
			this->label2->AutoSize = true;
			this->label2->Location = System::Drawing::Point(6, 54);
			this->label2->Name = L"label2";
			this->label2->Size = System::Drawing::Size(42, 13);
			this->label2->TabIndex = 3;
			this->label2->Text = L"Node 2";
			// 
			// label3
			// 
			this->label3->AutoSize = true;
			this->label3->Location = System::Drawing::Point(6, 83);
			this->label3->Name = L"label3";
			this->label3->Size = System::Drawing::Size(42, 13);
			this->label3->TabIndex = 4;
			this->label3->Text = L"Node 3";
			// 
			// groupBox1
			// 
			this->groupBox1->Controls->Add(this->label25);
			this->groupBox1->Controls->Add(this->label26);
			this->groupBox1->Controls->Add(this->label27);
			this->groupBox1->Controls->Add(this->label28);
			this->groupBox1->Controls->Add(this->label11);
			this->groupBox1->Controls->Add(this->label15);
			this->groupBox1->Controls->Add(this->label13);
			this->groupBox1->Controls->Add(this->label9);
			this->groupBox1->Location = System::Drawing::Point(375, 10);
			this->groupBox1->Name = L"groupBox1";
			this->groupBox1->Size = System::Drawing::Size(129, 163);
			this->groupBox1->TabIndex = 20;
			this->groupBox1->TabStop = false;
			this->groupBox1->Text = L"Constants";
			// 
			// label25
			// 
			this->label25->Anchor = System::Windows::Forms::AnchorStyles::Right;
			this->label25->AutoSize = true;
			this->label25->Location = System::Drawing::Point(89, 26);
			this->label25->Name = L"label25";
			this->label25->Size = System::Drawing::Size(22, 13);
			this->label25->TabIndex = 6;
			this->label25->Text = L"0.0";
			// 
			// label26
			// 
			this->label26->Anchor = System::Windows::Forms::AnchorStyles::Right;
			this->label26->AutoSize = true;
			this->label26->Location = System::Drawing::Point(89, 53);
			this->label26->Name = L"label26";
			this->label26->Size = System::Drawing::Size(22, 13);
			this->label26->TabIndex = 9;
			this->label26->Text = L"0.0";
			// 
			// label27
			// 
			this->label27->Anchor = System::Windows::Forms::AnchorStyles::Right;
			this->label27->AutoSize = true;
			this->label27->Location = System::Drawing::Point(89, 81);
			this->label27->Name = L"label27";
			this->label27->Size = System::Drawing::Size(22, 13);
			this->label27->TabIndex = 7;
			this->label27->Text = L"0.0";
			// 
			// label28
			// 
			this->label28->Anchor = System::Windows::Forms::AnchorStyles::Right;
			this->label28->AutoSize = true;
			this->label28->Location = System::Drawing::Point(89, 110);
			this->label28->Name = L"label28";
			this->label28->Size = System::Drawing::Size(22, 13);
			this->label28->TabIndex = 8;
			this->label28->Text = L"0.0";
			// 
			// label11
			// 
			this->label11->AutoSize = true;
			this->label11->Location = System::Drawing::Point(6, 26);
			this->label11->Name = L"label11";
			this->label11->Size = System::Drawing::Size(72, 13);
			this->label11->TabIndex = 2;
			this->label11->Text = L"Max Distance";
			// 
			// label15
			// 
			this->label15->AutoSize = true;
			this->label15->Location = System::Drawing::Point(6, 53);
			this->label15->Name = L"label15";
			this->label15->Size = System::Drawing::Size(80, 13);
			this->label15->TabIndex = 5;
			this->label15->Text = L"Max Movement";
			// 
			// label13
			// 
			this->label13->AutoSize = true;
			this->label13->Location = System::Drawing::Point(6, 81);
			this->label13->Name = L"label13";
			this->label13->Size = System::Drawing::Size(55, 13);
			this->label13->TabIndex = 3;
			this->label13->Text = L"Max Wind";
			// 
			// label9
			// 
			this->label9->AutoSize = true;
			this->label9->Location = System::Drawing::Point(6, 110);
			this->label9->Name = L"label9";
			this->label9->Size = System::Drawing::Size(44, 13);
			this->label9->TabIndex = 4;
			this->label9->Text = L"Max Tilt";
			// 
			// button2
			// 
			this->button2->Location = System::Drawing::Point(12, 148);
			this->button2->Name = L"button2";
			this->button2->Size = System::Drawing::Size(75, 23);
			this->button2->TabIndex = 19;
			this->button2->Text = L"Stop";
			this->button2->UseVisualStyleBackColor = true;
			// 
			// button1
			// 
			this->button1->Location = System::Drawing::Point(12, 119);
			this->button1->Name = L"button1";
			this->button1->Size = System::Drawing::Size(75, 23);
			this->button1->TabIndex = 18;
			this->button1->Text = L"Start";
			this->button1->UseVisualStyleBackColor = true;
			this->button1->Click += gcnew System::EventHandler(this, &nnWindow::button1_Click);
			// 
			// nnWindow
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->ClientSize = System::Drawing::Size(516, 181);
			this->Controls->Add(this->button5);
			this->Controls->Add(this->button4);
			this->Controls->Add(this->button3);
			this->Controls->Add(this->groupBox3);
			this->Controls->Add(this->groupBox2);
			this->Controls->Add(this->groupBox1);
			this->Controls->Add(this->button2);
			this->Controls->Add(this->button1);
			this->Name = L"nnWindow";
			this->Text = L"Neural-Net Window";
			this->Load += gcnew System::EventHandler(this, &nnWindow::nnWindow_Load);
			this->groupBox3->ResumeLayout(false);
			this->groupBox3->PerformLayout();
			this->groupBox2->ResumeLayout(false);
			this->groupBox2->PerformLayout();
			this->groupBox1->ResumeLayout(false);
			this->groupBox1->PerformLayout();
			this->ResumeLayout(false);

		}
#pragma endregion
		private: System::Void button1_Click(System::Object^  sender, System::EventArgs^  e)
		{

			_constantValues newC;
			mathLibrary::initRand();
			float val1 = mathLibrary::randonGenFn(1.0, 200.0);
			float val2 = mathLibrary::randonGenFn(1.0, 200.0);
			float val3 = mathLibrary::randonGenFn(1.0, 200.0);
			float val4 = mathLibrary::randonGenFn(1.0, 200.0);
			float val5 = mathLibrary::randonGenFn(1.0, 200.0);
			float val6 = mathLibrary::randonGenFn(1.0, 200.0);

			float val7 = mathLibrary::randonGenFn(1.0, 200.0);


			float testVal[] = {val1, val2, val3};
			float testVal2[] = {val4, val5, val6};
			float testFloat[1] = {val7};
			float testMaxValue = newC._maxD;
			int nodeType = 1;
			float *testPointer1;
			testPointer1 = testVal;

			_nodeTemplate distNode(nodeType, testVal, testVal2, 'X', newC._maxD);
			_nodeTemplate movNode(2, testVal, testVal2, 'X', newC._maxM);
			_nodeTemplate tiltXNode(3, testVal, testVal2, 'X', newC._maxT);
			_nodeTemplate tiltYNode(3, testVal, testVal2, 'Y', newC._maxT);
			_nodeTemplate tiltZNode(3, testVal, testVal2, 'Z', newC._maxT);

			distNode.update();
			movNode.update();
			tiltXNode.update();
			tiltYNode.update();
			tiltZNode.update();
			
			//Nodes

			this->label6->Text = Convert::ToString(distNode._currVal);
			this->label16->Text = Convert::ToString(movNode._currVal);
			this->label18->Text = Convert::ToString(tiltXNode._currVal);
			this->label8->Text = Convert::ToString(tiltYNode._currVal);
			this->label7->Text = Convert::ToString(tiltZNode._currVal);

			//Current Values

			this->label19->Text = Convert::ToString(distNode._iVal);
			this->label21->Text = Convert::ToString(movNode._iVal);
			this->label23->Text = Convert::ToString(tiltXNode._iVal);
			this->label24->Text = Convert::ToString(tiltYNode._iVal);
			this->label22->Text = Convert::ToString(tiltZNode._iVal);

			//Constants
			this->label25->Text = Convert::ToString(newC._maxD);
			this->label27->Text = Convert::ToString(newC._maxW);
			this->label28->Text = Convert::ToString(newC._maxT);
			this->label26->Text = Convert::ToString(newC._maxM);
			

		}
		
		private: System::Void nnWindow_Load(System::Object^  sender, System::EventArgs^  e) 
		{

		}

};
}
