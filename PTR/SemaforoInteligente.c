/* 
Trabalho de Programação em Tempo Real
Professor Jes de Cerqueira
Alunas: Andressa Andrade e Renata Antunes

Semaforo Inteligente implementado com DuinOS

Temos Tres Tarefas a serem executadas, cada uma com um nivel de prioridade
sendo: 
a mais basica o funcionamento de um semaforo simples
a segunda de acionamento do sinal para pedestres
e a terceira a de trens
*/

#define vermelhoCarro    2                 // LED Vermelho Semáforo - Carro  
#define amareloCarro     3                 // LED Amarelo Semáforo - Carro  
#define verdeCarro       4                 // LED Verde Semáforo - Carro 
#define vermelhoPedestre 5                 // LED Vermelho Semáforo - Pedestre  
#define verdePedestre    6                 // LED Verde Semáforo - Pedestre  
#define botao            8                 // Botão 

int  flag = 0; 
boolean sinalAberto = true;
boolean pedestre = false;

const int a = 10;
const int b = 11;
const int c = 12;
const int d = 13;

declareTaskLoop(semaforoPedestre);
declareTaskLoop(semaforoCarro);

taskLoop(semaforoCarro)
{
  sinalAberto = true;
  delay(10000);
}

taskLoop(semaforoPedestre)
{
    if(pedestre){
      sinalAberto = false;
      delay(2000);
      digitalWrite(vermelhoPedestre, LOW);
      digitalWrite(verdePedestre, HIGH);
      delay(10000);
      digitalWrite(verdePedestre, LOW);
      digitalWrite(vermelhoPedestre, HIGH);
      //delay(5000);
      pedestre = false;
    }
    suspend();
}

void setup()   
{                
  pinMode(vermelhoCarro, OUTPUT);  
  pinMode(amareloCarro, OUTPUT);  
  pinMode(verdeCarro, OUTPUT);
  pinMode(vermelhoPedestre, OUTPUT);  
  pinMode(verdePedestre, OUTPUT); 
  pinMode(a, OUTPUT);
  pinMode(b, OUTPUT);
  pinMode(c, OUTPUT);
  pinMode(d, OUTPUT); 
  digitalWrite(vermelhoPedestre, HIGH);
  
  createTaskLoop(semaforoCarro, LOW_PRIORITY);
  createTaskLoop(semaforoPedestre, NORMAL_PRIORITY);
  //createTaskLoop(semaforoTrem,HIGH_PRIORITY); 
}

void loop()                     
{
  flag = digitalRead(botao);
  if(!flag){
    if (sinalAberto)
    {
       digitalWrite(vermelhoCarro, LOW);  
       digitalWrite(verdeCarro, HIGH);
       nextTask();
    }
    else
    {  
      digitalWrite(verdeCarro, LOW);  
      digitalWrite(amareloCarro, HIGH);  
      delay(2000);  
      digitalWrite(amareloCarro, LOW);  
      digitalWrite(vermelhoCarro, HIGH);
      delay(10000);
      nextTask();
    }
  }
  else{
      pedestre = true;
      resumeTask(semaforoPedestre);
      nextTask();
  }   
}
