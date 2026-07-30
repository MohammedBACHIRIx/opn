# HIL Dev Sim Research Protocol (Protocol-to-Paper Package)

## 1) Protocol Overview

**Working title**  
Impact of Human-in-the-Loop Development Simulation on Software Task Outcomes

**Objective**  
Evaluate whether a Human-in-the-Loop (HIL) development simulation workflow improves task quality and delivery efficiency compared with a non-HIL baseline workflow.

**Primary research question (RQ1)**  
Does HIL dev sim improve objective task performance compared with baseline development workflow?

**Secondary research questions**
- **RQ2:** Does HIL dev sim reduce time-to-completion without reducing quality?
- **RQ3:** How does HIL dev sim affect user trust, perceived cognitive load, and satisfaction?
- **RQ4:** Under which participant characteristics (experience/tool familiarity) are effects strongest?

**Hypotheses**
- **H1 (primary):** HIL dev sim yields higher task quality scores than baseline.
- **H2:** HIL dev sim reduces task completion time.
- **H3:** HIL dev sim reduces error rates/rework events.
- **H4:** HIL dev sim improves trust and satisfaction while not increasing cognitive load.

**Primary outcome**  
Composite task quality score (predefined weighted metric).

**Secondary outcomes**  
Completion time, error count, rework count, trust score, NASA-TLX score, satisfaction score.

---

## 2) Study Design

**Design type**  
Mixed-methods, randomized within-subject crossover study.

**Conditions**
- **Condition A (HIL dev sim):** Participants complete tasks using HIL-enabled workflow.
- **Condition B (Baseline):** Participants complete equivalent tasks without HIL support.

**Allocation and order control**
- Participants randomized to order AB or BA.
- Counterbalanced task packs to mitigate learning/order effects.

**Timeline**
- **Pilot phase:** instrument and workflow validation.
- **Main phase:** full participant data collection.
- **Follow-up phase:** optional debrief interviews and robustness checks.

---

## 3) Participants

**Target population**  
Software developers (junior to senior) with basic proficiency in the study language/toolchain.

**Sampling strategy**
- Stratified convenience sampling by experience level.
- Recruitment from universities, developer communities, and professional networks.

**Inclusion criteria**
- Age 18+
- Prior coding experience (minimum threshold defined in screener)
- Consent to session recording/logging

**Exclusion criteria**
- Inability to complete both conditions
- Prior participation in pilot (for main study)
- Failure on comprehension checks

**Sample size rationale**
- Power-based target where feasible (paired design, expected medium effect).
- If constrained, feasibility target with justification and transparent limitation statement.

**Compensation**
- Fixed stipend per completed session, with clear policy for partial completion.

---

## 4) Tasks and Scenarios

**Task construction principles**
- Standardized, realistic dev-sim tasks with equivalent complexity.
- Same domain and constraints across conditions.
- Objective grading rubric prepared before study launch.

**Session flow**
1. Onboarding and consent
2. Training/warm-up task
3. Condition 1 task set
4. Post-condition survey
5. Break
6. Condition 2 task set
7. Post-condition survey
8. Final survey/interview

**Task controls**
- Fixed time limits per task.
- Explicit start/end rules.
- Predefined handling for interruptions, retries, and tool/system failures.

---

## 5) Variables and Measures

### Independent variable
- Workflow condition: HIL dev sim vs baseline.

### Dependent variables
- **Performance quality:** rubric score, test pass rate, defect density.
- **Efficiency:** completion time, throughput (tasks completed).
- **Reliability:** error events, rollback/rework counts.
- **Human factors:** trust, cognitive load (NASA-TLX), satisfaction.

### Covariates
- Experience level, domain familiarity, tool familiarity, language proficiency.

### Metric definitions (locked pre-collection)
- `quality_composite = w1*rubric_norm + w2*test_pass_norm - w3*defect_density_norm`
- `efficiency_time = end_timestamp - start_timestamp`
- `error_rate = error_events / active_minutes`
- `trust_score = mean(trust_scale_items)`
- `cognitive_load_score = NASA_TLX_global`

---

## 6) Data Collection and Instrumentation

**System telemetry**
- Timestamped events: task start/end, compile/test runs, error events, retries, context switches.
- Interaction logs specific to HIL interventions.

**Artifact outcomes**
- Code/output artifacts
- Automated checks and rubric-based review outcomes

**Human-subject data**
- Pre-study profile survey
- Post-condition survey (trust, load, satisfaction)
- Optional semi-structured interview

**Data dictionary requirements**
- Each variable includes: name, type, source system, unit, transform rule, missing-data code.

**Data integrity checks**
- Clock sync validation
- Missingness audit
- Duplicated event detection

---

## 7) Analysis Plan (Predefined)

**Primary analysis**
- Paired comparison of quality composite between HIL and baseline.
- Report effect size and 95% CI.

**Secondary analyses**
- Paired tests for completion time, error rate, trust, cognitive load, satisfaction.
- Mixed-effects modeling with participant random effects and covariates.

**Multiple comparisons**
- Control false discovery rate for secondary endpoints.

**Assumption and robustness checks**
- Normality diagnostics and non-parametric fallback.
- Sensitivity analyses excluding protocol deviations.

**Missing data handling**
- Predefined rules: complete-case for primary endpoint unless missingness threshold exceeded; then imputation strategy declared.

**Qualitative analysis (if interviews are used)**
- Thematic coding with predefined codebook.
- Dual-coding subset and inter-rater reliability calculation.

---

## 8) Ethics and Governance

**Consent and participant rights**
- Written informed consent before data collection.
- Right to withdraw at any time without penalty.

**Privacy and security controls**
- Pseudonymized participant IDs.
- Removal of direct identifiers from analysis datasets.
- Access-controlled storage and defined retention period.

**Risk and mitigation**
- Low-to-moderate participant burden managed via breaks and time caps.
- Procedure for technical incidents and participant distress.

**Oversight**
- IRB/ethics submission path documented before main phase launch.

---

## 9) Quality Control

**Pilot study**
- Run pilot with small sample to validate clarity, instrumentation, and timing.
- Revise protocol once, lock version before main phase.

**Facilitator controls**
- Standardized session checklist
- Scripted instructions to reduce facilitator variance

**Deviation management**
- Structured deviation log: timestamp, type, impact, corrective action.

**Versioning and reproducibility**
- Version protocol, instruments, and analysis scripts.
- Preserve immutable snapshots for preregistration and publication traceability.

---

## 10) Protocol Outputs (Ready for Paper)

1. Final protocol document (this file)
2. Preregistration package (template below)
3. Instruments appendix (template below)
4. Analysis appendix (template below)

---

## Appendix A — Preregistration Template

- Study title and version
- Research questions and hypotheses (H1–H4)
- Design and randomization procedure
- Inclusion/exclusion criteria
- Primary and secondary outcomes
- Metric formulas and thresholds
- Statistical methods and correction strategy
- Missing data policy
- Deviation policy
- Data sharing and reproducibility statement

---

## Appendix B — Instruments Template

**B1. Pre-study profile survey**
- Role, years of experience, domain familiarity, tool familiarity.

**B2. Post-condition survey**
- Trust scale items
- NASA-TLX items
- Satisfaction/usability items

**B3. Interview guide (optional)**
- Perceived strengths/limitations of each condition
- Decision confidence and error recovery experience
- Situations where HIL support was most/least useful

---

## Appendix C — Analysis Appendix Template

**C1. Planned tables**
- Participant characteristics table
- Primary and secondary endpoint comparison table
- Model coefficients table

**C2. Planned figures**
- Paired outcome plots (HIL vs baseline)
- Distribution and residual diagnostics
- Subgroup effect visualization

**C3. Reporting checklist**
- Hypothesis-to-result traceability
- Effect size + CI reporting
- Deviation and missing-data transparency
- Limitations and external validity statement
