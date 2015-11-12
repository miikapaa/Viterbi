function [MAP_state] = Viterbi_DNA(Obs)
% Uses a general version of Viterbi algorithm in Viterbi.m

% Takes observed DNA sequence as String form as input
% Output MAP_state contains the most probable sequence of hidden states for
% a given DNA sequence Obs.

% initiate HMM system
% Let observation space be {x_1,...,x_m}.
% State_space: vector containing possible hidden states y_1,...,y_n
% Initial_probabilities: Probabilities for first hidden states
% Transition_matrix: a matrix where element a_ij is probability of
% transiting from state y_i to y_j.
% Emission_matrix: a matrix where element b_ij is probability of 
% observing x_j from state y_i.
State_space = [1,2];
Initial_probabilities = [0.5, 0.5];
Transition_matrix = ..._
[0.5, 0.5;
 0.4, 0.6];
Emission_matrix = ..._
[0.2, 0.3, 0.3, 0.2;
 0.3, 0.2, 0.2, 0.3];

% Convert the DNA sequence from String format into numeric format using
% following equivalences:
%A = 1;
%C = 2;
%G = 3;
%T = 4;
Observation = zeros(1,length(Obs));
for i = 1:length(Obs)
        switch Obs(i)
            case 'A'
                Observation(i) = 1; 
            case 'C'
                Observation(i) = 2;
            case 'G'
                Observation(i) = 3;
            case 'T'
                Observation(i) = 4;
        end

end

% Call Viterbi algorithm
States = Viterbi(State_space, Initial_probabilities, Observation, Transition_matrix, Emission_matrix);

% Convert the the numervi HMM output from Viterbi algorithm into String
% format using following equivalences:
%H = 1;
%L = 2;
for i = 1:length(States)
        switch States(i)
            case 1
                MAP_state(i) = 'H'; 
            case 2
                MAP_state(i) = 'L';
        end

end

end
