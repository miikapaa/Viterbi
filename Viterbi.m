function [MAP_states] = Viterbi(State_space, Initial_probabilities, Observation, Transition_matrix, Emission_matrix)
% General Viterbi algorithm
% output MAP_states is the most probable sequence of hidden states for
% a given Observation sequence.
% Let observation space be {x_1,...,x_m}.
% Arguments:
% State_space: vector containing possible hidden states y_1,...,y_n
% Initial_probabilities: Probabilities for first hidden states
% Observation: a sequence of observations
% Transition_matrix: a matrix where element a_ij is probability of
% transiting from state y_i to y_j.
% Emission_matrix: a matrix where element b_ij is probability of 
% observing x_j from state y_i.

% Probabilities of paths will be stored here
S = zeros(length(State_space), length(Observation));

% Most probable path up to each step is stored here
b = zeros(length(State_space), length(Observation));

% Initiate output vector
Z = zeros(1, length(Observation));
MAP_states = zeros(1, length(Observation));

% Compute probabilities of first step
for i = State_space
    S(i,1) = Initial_probabilities(i)*Emission_matrix(i,Observation(1));
    b(i,1) = 0;
end

% step by step compute the most likely paths up to step i. Probabilities
% are stored in S and the paths in b.
for i = 2:length(Observation)
    for k = State_space
        
     [S(k,i), b(k,i)] = max(S(:,i-1) .* Transition_matrix(:,k) * Emission_matrix(k,Observation(i)));
    
    end
end

% find the most likely hidden state in the end of the sequence
[~, Z(length(Observation))] = max(S(:,length(Observation)));
MAP_states(length(Observation)) = State_space(Z(length(Observation)));

% backtrack the hidden sequence step by step from b
for i = 2:length(Observation)
k = length(Observation)- i + 2;

Z(k-1) = b(Z(k),k);
MAP_states(k-1) = State_space(Z(k-1));
end

end

