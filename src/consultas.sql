/* Listar a relação de unidades acadêmicas, com o total de departamentos, cursos e 
alunos. No resultado deve aparecer ordenado de forma decrescente por número de 
alunos. No resultado deve aparecer apenas o nome da unidade acadêmica e os totais 
solicitados */

SELECT
	ua.nome,
	COUNT(DISTINCT dep.codigo_seq) AS "Número de Departamentos",
	COUNT(DISTINCT dc.codigo_curso) AS "Número de Cursos",
	COUNT(DISTINCT a.matricula) AS "Número de Alunos"
	FROM
		unidade_academica ua
		LEFT OUTER JOIN departamento dep ON ua.codigo_seq = dep.codigo_UA
		LEFT OUTER JOIN departamento_curso dc ON dep.codigo_seq = dc.codigo_departamento
		LEFT OUTER JOIN aluno a ON dc.codigo_curso = a.codigo_curso
		GROUP BY ua.codigo_seq, ua.nome
		ORDER BY 4 DESC;

/* Listar o histórico escolar dos alunos do curso de Ciência da Computação, informando 
o nome da disciplina, quantidade de créditos, semestre cursado, nota 1a. AP, nota 2a. 
AP e AF. Para alunos que não fizeram AF, a coluna referente a este atributo deve 
aparecer */

SELECT a.nome AS "Aluno", d.nome AS "Disciplina", d.creditos AS "Créditos", ad.semestre AS "Semestre", ad.ap1 AS "AP1", ad.ap2 AS "AP2", ad.af AS "AF"
	FROM aluno a
	INNER JOIN curso c ON a.codigo_curso = c.codigo_seq
	LEFT OUTER JOIN aluno_disciplina ad ON a.matricula = ad.matricula_aluno
	INNER JOIN disciplina d ON d.codigo_disciplina = ad.codigo_disciplina
	WHERE c.nome LIKE 'Ciência da Computação%'
	ORDER BY a.nome, ad.semestre, d.nome;

/*  Listar o nome dos professores do Centro de Ciências que ministraram menos de 8 
créditos por semestre, nos semestres 2018.1 e 2018.2. */

SELECT p.nome AS "Professor", SUM(d.creditos) AS "Créditos"
    FROM professor p
    INNER JOIN professor_disciplina pd ON p.matricula = pd.matricula_professor
    INNER JOIN disciplina d ON pd.codigo_disciplina = d.codigo_disciplina
    INNER JOIN departamento dep ON p.lotacao = dep.codigo_seq
    INNER JOIN unidade_academica ua ON dep.codigo_UA = ua.codigo_seq
    WHERE ua.nome LIKE 'Centro de Ciências%'
    GROUP BY p.nome
    HAVING SUM(d.creditos) < 8
    ORDER BY 2;