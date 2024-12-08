% AHP Implementation 
% Ορισμός των συγκρίσεων για τα κριτήρια 
% Ορισμός νέας μήτρας συγκρίσεων κριτηρίων (βελτιωμένη) criteria_matrix = [ 
1 	2 	0.5 	0.33;
0.5 	1 	0.25	 0.5;
 2	 4	 1	 3;
 3	 2	 1/3	 1 
];
 % Υπολογισμός ιδιοτιμών και ιδιοδιανυσμάτων (Eigenvalues & Eigenvectors) [V, D] = eig(criteria_matrix); 
lambda_max = max(diag(D)); % Μέγιστη ιδιοτιμή
% Υπολογισμός Consistency Index (CI) και Consistency Ratio (CR)
 n = size(criteria_matrix, 1); % Μέγεθος της μήτρας (αριθμός κριτηρίων)
consistency_index = (lambda_max - n) / (n - 1); 
% Ορισμός Random Index (RI) ανάλογα με το μέγεθος της μήτρας (n) 
random_index_values = [0, 0, 0.58, 0.9, 1.12, 1.24, 1.32, 1.41, 1.45]; % Τυπικές τιμές RI
random_index = random_index_values(n); 
% Υπολογισμός του Consistency Ratio (CR) 
consistency_ratio = consistency_index / random_index; 
% Έλεγχος συνέπειας (CR < 0.1) 
if consistency_ratio > 0.1 
	disp('Η μήτρα δεν είναι συνεπής. Επαναλάβετε την αξιολόγηση.'); 
	else disp('Η μήτρα είναι συνεπής.'); 
end 
% Κανονικοποίηση των ιδιοδιανυσμάτων για την εύρεση των προτεραιοτήτων
 priority_vector = V(:, find(diag(D) == lambda_max)); priority_vector = priority_vector / sum(priority_vector);
 % Κανονικοποίηση 
% Εμφάνιση των τελικών προτεραιοτήτων (βαρών) των εναλλακτικών λύσεων disp('Προτεραιότητες των εναλλακτικών:'); disp(priority_vector); 
% Τέλος της ανάλυσης
