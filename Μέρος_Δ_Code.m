% MACBETH Method Implementation

% Ορισμός μήτρας συγκρίσεων βασισμένων στην ελκυστικότητα των κριτηρίων
% 1 = Χωρίς διαφορά, 7 = Απόλυτη διαφορά
macbeth_matrix = [
    1    4    2    5;
    0    1    3    6;
    0    0    1    3;
    0    0    0    1
];

% Συμμετρική μήτρα - συμπληρώνουμε τις κάτω τιμές με την ανάλογη συμμετρική
for i = 1:size(macbeth_matrix, 1)
    for j = 1:i-1
        macbeth_matrix(i, j) = 7 - macbeth_matrix(j, i);
    end
end

disp('Μήτρα Σύγκρισης Ελκυστικότητας (MACBETH):');
disp(macbeth_matrix);

% Υπολογισμός μέσων τιμών για κάθε κριτήριο
% Για απλότητα, ορίζουμε τα βάρη ως τους μέσους όρους των τιμών της μήτρας για κάθε κριτήριο
n = size(macbeth_matrix, 1);
weights = zeros(n, 1);

for i = 1:n
    weights(i) = mean(macbeth_matrix(i, :));
end

% Κανονικοποίηση των βαρών ώστε το άθροισμά τους να είναι 1
weights = weights / sum(weights);

disp('Κανονικοποιημένα βάρη των κριτηρίων:');
disp(weights);

% Εφαρμογή των βαρών σε υποθετικές εναλλακτικές λύσεις
% Ορίζουμε μια υποθετική βαθμολογία για κάθε εναλλακτική για κάθε κριτήριο
alternatives = [
    0.8  0.7  0.9  0.6;  % Εναλλακτική 1
    0.7  0.9  0.8  0.7;  % Εναλλακτική 2
    0.6  0.8  0.7  0.9   % Εναλλακτική 3
];

% Υπολογισμός της τελικής ελκυστικότητας κάθε εναλλακτικής (βαθμολογίες)
final_scores = alternatives * weights;

disp('Τελικές ελκυστικότητες εναλλακτικών:');
disp(final_scores);

% Βαθμολογία και κατάταξη των εναλλακτικών
[sorted_scores, ranking] = sort(final_scores, 'descend');

disp('Κατάταξη των εναλλακτικών (από την πιο ελκυστική στην λιγότερο):');
disp(ranking);
