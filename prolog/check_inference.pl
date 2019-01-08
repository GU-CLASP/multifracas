% Level 0
%	:- [input,level0rules,pretty_print].

% Level 1 - prudent & radical
%	:- [input,level1rulesP,pretty_print].
%	:- [input,level1rulesR,pretty_print].

% Level 2 - prudent & radical
%	:- [input,level2rulesP,pretty_print].
%	:- [input,level2rulesR,pretty_print].

% Level 3 - prudent & radical
%	:- [input,level3rulesP,pretty_print].
	:- [input,level3rulesR,pretty_print].


% check_inference(+Premises,+Hypothesis,+Question,?ID,?Ans).

check_inferences :- findall(X,check_inference(X),_).

check_inference(ID) :- input(ID,Premises,Hypothesis,Question),
	rule(RuleID,RulePremises,Hypothesis,Question,Answer),
	match_premises(Premises,RulePremises,RuleID),
	remove_level(RuleID,PlainRuleID),
	pprintq(inference(ID,Answer,PlainRuleID)).

remove_level(RuleID,PlainRuleID) :- member(Level,['0','1','2','3']),
	concat(MidRule,Level,RuleID),
	concat(PlainRuleID,'_l',MidRule).

match_premises(Premises,Premises,_):- !.
match_premises(Premises,RulePremises,RuleID) :- not(ordered_premises(RuleID)), match(Premises,RulePremises).

match([],[]).
match([P1|P1L],[P1|P2L]) :- match(P1L,P2L), !.
match([P1|P1L],[P2|P2L]) :- member(P1,P2L), append(P2L,[P2],P2L2), match([P1|P1L],P2L2), !.

ordered_premises(RuleID) :- ordered(Ordered),
	member(Level,['0','1','2','3']),
	concat(Ordered,Level,RuleID).

ordered('r_111_l').
ordered('r_113_l').
ordered('r_117_l').
ordered('r_118_l').
ordered('r_119_l').
ordered('r_120_l').
ordered('r_121_l').
ordered('r_122_l').
ordered('r_123_l').
ordered('r_124_l').
ordered('r_125_l').
ordered('r_126_l').
ordered('r_127_l').
ordered('r_128_l').
ordered('r_129_l').
ordered('r_130_l').
ordered('r_131_l').
ordered('r_132_l').
ordered('r_133_l').
ordered('r_137_l').
ordered('r_138_l').
ordered('r_142_l').
ordered('r_143_l').
ordered('r_144_l').
ordered('r_145_l').
ordered('r_146_l').
ordered('r_147_l').
ordered('r_148_l').
ordered('r_149_l').
ordered('r_154_l').
ordered('r_155_l').
ordered('r_156_l').
ordered('r_157_l').
ordered('r_158_l').
ordered('r_159_l').
ordered('r_160_l').
ordered('r_161_l').
ordered('r_162_l').
ordered('r_163_l').
ordered('r_164_l').
ordered('r_165_l').
ordered('r_166_l').
ordered('r_167_l').
ordered('r_168_l').
ordered('r_171_l').
ordered('r_196_l').
ordered('r_259_l').
ordered('r_284_l').
ordered('r_309_l').
ordered('r_310_l').
ordered('r_311_l').
ordered('r_314_l').
ordered('r_317_l').
ordered('r_318_l').
ordered('r_325_l').
