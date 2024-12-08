% AHP Monte Carlo Sensitivity Analysis - Ερώτημα Γ
% Προσομοίωση Monte Carlo για N=103 επαναλήψεις, με αφαίρεση 5 ειδικών σε κάθε επανάληψη.

% Συνάρτηση για υπολογισμό της μέσης γεωμετρικής κάθε στήλης (γεωμετρικός μέσος για AHP)
function priority_vector = geometric_mean_method(matrix)
    num_criteria = size(matrix, 1);
    geometric_means = prod(matrix, 2) .^ (1 / num_criteria);  % Υπολογισμός γεωμετρικού μέσου
    priority_vector = geometric_means / sum(geometric_means);  % Κανονικοποίηση
end

% Δυναμικός υπολογισμός AHP με Monte Carlo προσομοίωση
function monte_carlo_ahp(num_experts, num_criteria, N, expert_matrices)
    % N: αριθμός επαναλήψεων Monte Carlo
    % num_experts: αριθμός ειδικών (15)
    % num_criteria: αριθμός κριτηρίων (4 ή περισσότερα)
    
    selected_experts_size = 10;  % Αριθμός ειδικών που θα επιλέγονται σε κάθε επανάληψη
    rankings = zeros(N, num_criteria);  % Αρχικοποίηση πίνακα για αποθήκευση κατατάξεων

    % Υπολογισμός αρχικής κατάταξης από όλους τους ειδικούς (Μέρος Β)
    combined_matrix = zeros(num_criteria);
    for k = 1:num_experts
        combined_matrix = combined_matrix + expert_matrices{k};
    end
    combined_matrix = combined_matrix / num_experts;
    initial_priority_vector = geometric_mean_method(combined_matrix);  % Προτεραιότητες από όλους τους ειδικούς
    [~, initial_ranking] = sort(initial_priority_vector, 'descend');  % Αρχική κατάταξη εναλλακτικών

    % Εκτέλεση προσομοίωσης Monte Carlo (103 επαναλήψεις)
    for i = 1:N
        % Χρησιμοποιούμε τη randperm για τυχαία επιλογή 10 από 15 ειδικούς
        selected_experts = randperm(num_experts, selected_experts_size);  
        combined_matrix = zeros(num_criteria);  % Αρχικοποίηση μήτρας για τους επιλεγμένους ειδικούς
        
        % Συνδυασμός των μήτρων των 10 επιλεγμένων ειδικών
        for j = 1:selected_experts_size
            combined_matrix = combined_matrix + expert_matrices{selected_experts(j)};
        end
        combined_matrix = combined_matrix / selected_experts_size;  % Υπολογισμός του μέσου όρου των 10 ειδικών
        
        % Υπολογισμός AHP προτεραιοτήτων για την τρέχουσα μήτρα
        priority_vector = geometric_mean_method(combined_matrix);
        
        % Αποθήκευση κατάταξης για την τρέχουσα επανάληψη
        [~, ranking] = sort(priority_vector, 'descend');  % Κατάταξη των εναλλακτικών
        rankings(i, :) = ranking;
    end

    % Ανάλυση αποτελεσμάτων
    reversal_count = 0;  % Καταμέτρηση αλλαγών κατάταξης
    for i = 1:N
        if ~isequal(rankings(i, :), initial_ranking)
            reversal_count = reversal_count + 1;
        end
    end

    % Εμφάνιση αποτελεσμάτων
    disp('Αποτελέσματα Monte Carlo (κατατάξεις σε κάθε επανάληψη):');
    disp(rankings);
    disp(['Αριθμός επαναλήψεων όπου η κατάταξη άλλαξε: ', num2str(reversal_count)]);
    disp(['Αριθμός επαναλήψεων όπου η κατάταξη έμεινε ίδια: ', num2str(N - reversal_count)]);
end

% ====== Εισαγωγή Δεδομένων ======

% Αριθμός ειδικών (15) και κριτηρίων (π.χ., 4)
num_experts = 15;
num_criteria = 4;
N = 103;  % Αριθμός επαναλήψεων Monte Carlo

% Δημιουργία τυχαίων μήτρων AHP για τους 15 ειδικούς με μεγαλύτερες διαφορές
expert_matrices = cell(num_experts, 1);
for k = 1:num_experts
    % Μήτρα AHP για κάθε ειδικό με μεγαλύτερες τυχαίες διακυμάνσεις
    expert_matrices{k} = [
        1        2        0.5       0.33;
        0.5      1        0.25      0.5 + rand() * 0.5;  % Αυξημένες τυχαίες διακυμάνσεις
        2        4        1         3 + rand() * 0.5;
        3        2        1/3       1 + rand() * 0.5
    ];
end

% Κλήση της συνάρτησης Monte Carlo για την προσομοίωση
monte_carlo_ahp(num_experts, num_criteria, N, expert_matrices);
